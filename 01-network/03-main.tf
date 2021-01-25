resource "oci_core_virtual_network" "cld_DefaultVCN" {
  cidr_block     = "10.1.0.0/16"
  compartment_id = var.compartment_ocid
  display_name   = "cld_DefaultVCN"
  dns_label      = "cldDefaultVCN"
}

resource "oci_core_subnet" "cld_be_SubNet" {
  cidr_block        = "10.1.10.0/24"
  display_name      = "cld_be_SubNet"
  dns_label         = "cldBESubNet"
  security_list_ids = [oci_core_security_list.cld_DefaultSecurityList.id]
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_virtual_network.cld_DefaultVCN.id
  route_table_id    = oci_core_route_table.cld_DefaultRouteTable.id
  dhcp_options_id   = oci_core_virtual_network.cld_DefaultVCN.default_dhcp_options_id
}

resource "oci_core_subnet" "cld_lb_SubNet" {
  cidr_block        = "10.1.0.0/24"
  display_name      = "cld_lb_SubNet"
  dns_label         = "cldLBSubNet"
  security_list_ids = [oci_core_security_list.cld_DefaultSecurityList.id]
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_virtual_network.cld_DefaultVCN.id
  route_table_id    = oci_core_route_table.cld_DefaultRouteTable.id
  dhcp_options_id   = oci_core_virtual_network.cld_DefaultVCN.default_dhcp_options_id
}

resource "oci_core_internet_gateway" "cld_Default_IGW" {
  
  compartment_id = var.compartment_ocid
  display_name   = "cld_Default_IGW"
  vcn_id         = oci_core_virtual_network.cld_DefaultVCN.id
}

resource "oci_core_route_table" "cld_DefaultRouteTable" {
  
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.cld_DefaultVCN.id
  display_name   = "cld_DefaultRouteTable"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.cld_Default_IGW.id
  }
}

resource "oci_core_security_list" "cld_DefaultSecurityList" {
  
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_virtual_network.cld_DefaultVCN.id
  display_name   = "cld_DefaultSecurityList"

  egress_security_rules {
    protocol    = "6"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = "22"
      min = "22"
    }
  }

  ingress_security_rules {
    #description = <<Optional value not found in discovery>>
    icmp_options {
      code = "4"
      type = "3"
    }
    protocol    = "1"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"

  }
  ingress_security_rules {
    
    icmp_options {
      code = "-1"
      type = "3"
    }
    protocol    = "1"
    source      = "10.1.0.0/16"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    
  }

}
