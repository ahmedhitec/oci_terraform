resource "oci_core_instance" "tf-cld-srvr01" {
  availability_domain = var.AD_01
  compartment_id      = var.compartment_ocid
  display_name        = "cld-srvr01"
  shape               = var.compute_shape

  create_vnic_details {
    subnet_id        = var.subnet_ocid
    display_name     = "primaryvnic"
    assign_public_ip = true
    hostname_label   = "cld-srvr01"
  }

  source_details {
    source_type = "image"
    source_id   = var.ODI_ocid
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key)
  }
}


resource "oci_core_instance" "tf-cld-srvr02" {
  availability_domain = var.AD_01
  compartment_id      = var.compartment_ocid
  display_name        = "cld-srvr02"
  shape               = var.compute_shape

  create_vnic_details {
    subnet_id        = var.subnet_ocid
    display_name     = "primaryvnic"
    assign_public_ip = true
    hostname_label   = "cld-srvr02"
  }

  source_details {
    source_type = "image"
    source_id   = var.ODI_ocid
  }

  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key)
  }
}

output "cld-srvr01-srvr01" {
  value = oci_core_instance.tf-cld-srvr01.public_ip
}


output "cld-srvr01-srvr02" {
  value = oci_core_instance.tf-cld-srvr02.public_ip
}


