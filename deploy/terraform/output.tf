output "frontend_public_ips" {
    value = oci_core_instance.frontend[*].public_ip
}

output "backends_public_ips" {
    value = oci_core_instance.backend[*].public_ip
}

output "lb_public_ip" {
  value = oci_core_public_ip.reserved_ip.ip_address
}