resource "local_file" "backend_params" {
  content = templatefile("${path.module}/backend_params.tftpl",
    {
     db_password = random_password.autonomous_database_admin_password.result
     db_service = oci_database_autonomous_database.adb.connection_strings[0].profiles[0].value
    }
  )
  filename = "${path.module}/generated/backend_params.json"
}