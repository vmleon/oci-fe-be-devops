resource "oci_bastion_bastion" "bastion" {
  bastion_type     = "standard"
  compartment_id   = var.compartment_ocid
  target_subnet_id = oci_core_subnet.publicsubnet.id

  client_cidr_block_allow_list = ["0.0.0.0/0"]
  name                         = "bastion"
}

resource "oci_bastion_session" "test_session" {
  bastion_id = oci_bastion_bastion.bastion.id
  key_details {
    public_key_content = var.ssh_public_key
  }
  target_resource_details {
    #Required
    # session_type = "MANAGED_SSH"
    session_type = "PORT_FORWARDING"

    #Optional
    target_resource_operating_system_user_name = "opc" # oci_identity_user.test_user.name
  }
}
