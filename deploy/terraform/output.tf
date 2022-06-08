output "frontend_public_ips" {
    value = oci_core_instance.frontend[*].public_ip
}

output "backends_public_ips" {
    value = oci_core_instance.backend[*].public_ip
}

output "lb_public_ip" {
  value = oci_core_public_ip.reserved_ip.ip_address
}

output "high_connection_string" {
  value = oci_database_autonomous_database.adb.connection_strings[0].high
}

output "high_connection_string_profile" {
  value = oci_database_autonomous_database.adb.connection_strings[0].profiles[0].value
}

output "autonomous_name" {
  value = oci_database_autonomous_database.adb.db_name
}

output "autonomous_database_admin_password" {
  value = random_password.autonomous_database_admin_password.result
  sensitive = true
}

# For mTLS and Wallet connectivity consider the following code

# output "adb_wallet_password" {
#   value = random_password.adb_wallet_password.result
#   sensitive = true
# }