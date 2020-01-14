provider "nsxt" {
  host                 = "${var.host}"
  vmc_token            = "${var.vmc_token}"
  allow_unverified_ssl = true
}

resource "nsxt_policy_segment" "segment12" {
    display_name      = "segment-12"
    description       = "Terraform provisioned Segment"
    connectivity_path = "/infra/tier-1s/cgw"
subnet {
      cidr = "12.12.2.1/24"
}
}

resource "nsxt_policy_segment" "segment-tag" {
    display_name      = "segment-tag"
    description       = "Terraform provisioned Segment"
    connectivity_path = "/infra/tier-1s/cgw"
    tag {
      scope = "scope_nico",
      tag = "tag_nico"}
subnet {
      cidr = "172.16.200.1/24"
}
}

resource "nsxt_policy_segment" "segment123" {
    display_name      = "segment-123"
    description       = "Terraform provisioned Segment"
    connectivity_path = "/infra/tier-1s/cgw"
subnet {
      cidr = "12.12.22.1/24"
}
}

resource "nsxt_policy_segment" "segment124" {
    display_name      = "segment-124"
    description       = "Terraform provisioned Segment"
    connectivity_path = "/infra/tier-1s/cgw"
subnet {
      cidr = "12.12.24.1/24"
}
  advanced_config {
    "hybrid" = false,
    "local_egress" = false,
    "connectivity" = "OFF"
  }
}

resource "nsxt_policy_security_policy" "policy2" {
  domain       = "cgw"
  display_name = "policy2"
  description  = "Terraform provisioned Security Policy"
  category     = "Application"

  rule {
    display_name       = "rule name"
    source_groups      = ["${nsxt_policy_group.mygroup2.path}"]
    action             = "DROP"
    services           = ["${nsxt_policy_service.nico-service_l4port2.path}"]
    logged             = true
  }
}

resource "nsxt_policy_group" "mygroup2" {
  display_name = "my-policy-group2"
  description  = "Created from Terraform"
  domain       = "cgw"

  criteria {
    ipaddress_expression {
      ip_addresses = ["211.1.1.1", "212.1.1.2", "192.168.1.1-192.168.1.100"]
    }
  }
}

resource "nsxt_policy_service" "nico-service_l4port2" {
  description  = "L4 ports service provisioned by Terraform"
  display_name = "service-s2"

  l4_port_set_entry {
    display_name      = "TCP82"
    description       = "TCP port 82 entry"
    protocol          = "TCP"
    destination_ports = ["82"]
  }
}
