resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.tftpl",
    {
     frontend_public_ip = oci_core_instance.frontend[0].public_ip
     backend_public_ip = oci_core_instance.backend[0].public_ip
    }
  )
  filename = "${path.module}/generated/app.ini"
}