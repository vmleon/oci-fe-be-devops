variable "autonomous_database_db_name" {
  type = string
  default = "autonomous"
}

variable "autonomous_database_db_workload" {
  type = string
  # OLTP, DW, AJD, APEX
  default = "OLTP"
}

variable "autonomous_database_db_license" {
  type = string
  # "BRING_YOUR_OWN_LICENSE" or "LICENSE_INCLUDED"
  default = "LICENSE_INCLUDED"
}

variable "autonomous_database_db_whitelisted_ips" {
  type = list(string)
  default = ["0.0.0.0/0"] # Don't do this in prod
}

variable "autonomous_database_cpu_core_count" {
  type = number
  default = 1
}

variable "autonomous_database_data_storage_size_in_tbs" {
  type = number
  default = 1
}

resource "random_password" "autonomous_database_admin_password" {
  length           = 16
  special          = true
  min_numeric = 3
  min_special = 3
  min_lower = 3
  min_upper = 3
  override_special = "()-_[]{}?"
}

resource "oci_database_autonomous_database" "adb" {
    #Required
    compartment_id = var.compartment_ocid
    db_name = var.autonomous_database_db_name

    #Optional
    admin_password = random_password.autonomous_database_admin_password.result
    cpu_core_count = var.autonomous_database_cpu_core_count
    data_storage_size_in_tbs = var.autonomous_database_data_storage_size_in_tbs
    db_workload = var.autonomous_database_db_workload
    display_name = var.autonomous_database_db_name
    is_mtls_connection_required = false
    whitelisted_ips = var.autonomous_database_db_whitelisted_ips
    is_auto_scaling_enabled = true
    license_model = var.autonomous_database_db_license
}

# For mTLS and Wallet connectivity consider the following code

# resource "random_password" "adb_wallet_password" {
#   length  = 16
#   special = true
#   min_numeric = 3
#   min_special = 3
#   min_lower = 3
#   min_upper = 3
# }

# resource "oci_database_autonomous_database_wallet" "adb_wallet" {
#   autonomous_database_id = oci_database_autonomous_database.adb.id
#   password               = random_password.adb_wallet_password.result
#   base64_encode_content  = "true"
# }

# resource "local_file" "adb_wallet_file" {
#   content_base64 = oci_database_autonomous_database_wallet.adb_wallet.content
#   filename       = "${path.module}/generated/${var.autonomous_database_db_name}_wallet.zip"
# }