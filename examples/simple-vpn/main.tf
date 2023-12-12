provider "tencentcloud" {
  region = local.region
}

resource "tencentcloud_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  name       = "tf_vpn_gateway_vpc"
}

locals {
  region = "ap-guangzhou"

  vpn_map = {
    "ipec_vpn_instance" = {
      bandwidth = 5
      zone      = "ap-guangzhou-3"
      type      = "IPSEC"
      vpc_id    = tencentcloud_vpc.vpc.id
    }

    "ssl_vpn_instance" = {
      bandwidth = 5
      zone      = "ap-guangzhou-3"
      type      = "SSL"
      vpc_id    = tencentcloud_vpc.vpc.id

      vpn_tags = {
        created_by = "terraform"
      }
    }
  }
}

module "vpn_gateway" {
  source = "../../"

  for_each           = local.vpn_map
  vpn_gateway_name   = try(each.value.name, each.key)
  type               = try(each.value.type, null)
  vpc_id             = try(each.value.vpc_id, null)
  prepaid_renew_flag = try(each.value.prepaid_renew_flag, null)
  prepaid_period     = try(each.value.prepaid_period, null)
  max_connection     = try(each.value.max_connection, null)
  bandwidth          = try(each.value.bandwidth, null)
  vpn_tags           = try(each.value.vpn_tags, null)
}
