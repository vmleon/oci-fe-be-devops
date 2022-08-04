data "oci_identity_tenancy" "tenancy" {
  tenancy_id = var.tenancy_ocid
}

resource "random_string" "deploy_id" {
  length  = 4
  special = false
}
