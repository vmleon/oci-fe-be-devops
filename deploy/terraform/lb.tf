variable "load_balancer_shape_details_maximum_bandwidth_in_mbps" {
  default = 40
}

variable "load_balancer_shape_details_minimum_bandwidth_in_mbps" {
  default = 10
}

resource "oci_core_public_ip" "reserved_ip" {
  compartment_id = var.compartment_ocid
  lifetime       = "RESERVED"

  lifecycle {
    ignore_changes = [private_ip_id]
  }
}

resource "oci_load_balancer" "lb" {
  shape          = "flexible"
  compartment_id = var.compartment_ocid

  subnet_ids = [
    oci_core_subnet.publicsubnet.id,
  ]

  shape_details {
    maximum_bandwidth_in_mbps = var.load_balancer_shape_details_maximum_bandwidth_in_mbps
    minimum_bandwidth_in_mbps = var.load_balancer_shape_details_minimum_bandwidth_in_mbps
  }

  display_name = "Load Balancer"
  reserved_ips {
    id = oci_core_public_ip.reserved_ip.id
  }
}

resource "oci_load_balancer_backend_set" "lb_be_set_frontend" {
  name             = "lb_be_set_frontends"
  load_balancer_id = oci_load_balancer.lb.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = "80"
    protocol            = "HTTP"
    url_path            = "/"
  }

}

resource "oci_load_balancer_backend" "lb_be_frontend" {
  backendset_name = oci_load_balancer_backend_set.lb_be_set_frontend.name
  ip_address = oci_core_instance.frontend[0].public_ip
  load_balancer_id = oci_load_balancer.lb.id
  port = 80
}

resource "oci_load_balancer_backend_set" "lb_be_set_backend" {
  name             = "lb_be_set_backends"
  load_balancer_id = oci_load_balancer.lb.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = "3000"
    protocol            = "HTTP"
    url_path            = "/database"
  }

}

resource "oci_load_balancer_backend" "lb_be_backend" {
  backendset_name = oci_load_balancer_backend_set.lb_be_set_backend.name
  ip_address = oci_core_instance.backend[0].public_ip
  load_balancer_id = oci_load_balancer.lb.id
  port = 3000
}

resource "oci_load_balancer_load_balancer_routing_policy" "routing_policy" {
  condition_language_version = "V1"
  load_balancer_id = oci_load_balancer.lb.id
  name = "routing_policy"
  
  rules {
    name = "routing_to_backend"
    condition = "any(http.request.url.path ew (i '/database'))"
    actions {
      name = "FORWARD_TO_BACKENDSET"
      backend_set_name = oci_load_balancer_backend_set.lb_be_set_backend.name
    }
  }

  rules {
    name = "routing_to_frontend"
    condition = "any(http.request.url.path eq (i '/'))"
    actions {
      name = "FORWARD_TO_BACKENDSET"
      backend_set_name = oci_load_balancer_backend_set.lb_be_set_frontend.name
    }
  }
}

resource "oci_load_balancer_listener" "lb_listener" {
  load_balancer_id         = oci_load_balancer.lb.id
  name                     = "http"
  routing_policy_name      = oci_load_balancer_load_balancer_routing_policy.routing_policy.name
  default_backend_set_name = oci_load_balancer_backend_set.lb_be_set_frontend.name
  port                     = 80
  protocol                 = "HTTP"

  connection_configuration {
    idle_timeout_in_seconds = "2"
  }
}