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

      customer_gateway_name    = "ipec_customer_gateway"
      customer_gateway_address = "1.1.1.1"
      customer_gateway_tags = {
        tag = "test"
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

locals {
  ipec_map = {
    "ipec_related_resource" = {
      customer_gateway_name    = "ipec_customer_gateway"
      customer_gateway_address = "1.1.1.1"
      customer_gateway_tags = {
        tag = "test"
      }

      connection_name    = "connection_ipec"
      vpc_id             = tencentcloud_vpc.vpc.id
      vpn_gateway_id     = module.vpn_gateway["ipec_vpn_instance"].vpn_instance_id
      ike_local_address  = "81.71.18.160"
      ike_remote_address = "1.1.1.1"
      spd_policy = [
        {
          local_cidr_block   = "172.16.0.0/16"
          remote_cidr_blocks = "2.2.2.0/26"
        }
      ]
    }
  }
}

module "ipsec_vpn" {
  source = "../../modules/ipsec-vpn"

  for_each = local.ipec_map

  customer_gateway_name    = try(each.value.customer_gateway_name, null)
  customer_gateway_address = try(each.value.customer_gateway_address, null)
  customer_gateway_tags    = try(each.value.customer_gateway_tags, null)

  vpc_id             = try(each.value.vpc_id, null)
  connection_name    = try(each.value.connection_name, null)
  ike_local_address  = try(each.value.ike_local_address, null)
  ike_remote_address = try(each.value.ike_remote_address, null)
  vpn_gateway_id     = try(each.value.vpn_gateway_id, null)
  spd_policy         = try(each.value.spd_policy, null)
}
