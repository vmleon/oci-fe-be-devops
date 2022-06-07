output "frontend_public_ips" {
    value = oci_core_instance.frontend[*].public_ip
}

output "backends_public_ips" {
    value = oci_core_instance.backend[*].public_ip
}

output "lb_public_ip" {
  value = oci_core_public_ip.reserved_ip.ip_address
}

output "db_version" {
  value = oci_database_autonomous_database.adb.db_version
}

output "high_connection_string" {
  value = oci_database_autonomous_database.adb.connection_strings[0].high
}

output "connection_urls" {
  value = oci_database_autonomous_database.adb.connection_urls
}

output "autonomous_database_admin_password" {
  value = random_password.autonomous_database_admin_password.result
  sensitive = true
}

output "adb_wallet_password" {
  value = random_password.adb_wallet_password.result
  sensitive = true
}