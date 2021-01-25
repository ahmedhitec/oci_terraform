// Common
variable "ssh_public_key" {}

variable "compute_shape" {}


variable "oci_profile" {}

variable "compartment_ocid" {}

variable "AD_01" {}

variable "subnet_ocid" {}


// images
variable "ODI_ocid" { 
    description = "Oracle Cloud developer Image , Oracle Linux 7.9"
}

variable "ubuntu20_ocid" { 
    description = "Ubuntu 20.04 LTS"
}