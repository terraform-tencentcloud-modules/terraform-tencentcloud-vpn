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

locals {
  ssl_map = {
    "ssl_related_resource" = {
      vpn_gateway_id     = module.vpn_gateway["ssl_vpn_instance"].vpn_instance_id
      local_address = [
        "10.0.0.0/17",
      ]
      remote_address      = "11.0.0.0/16"
      ssl_vpn_server_name = "ssl_server"
      ssl_vpn_protocol    = "UDP"
      ssl_vpn_port        = 1194
      integrity_algorithm = "MD5"
      encrypt_algorithm   = "AES-128-CBC"
      compress            = true

      ssl_vpn_client_name = "ssl_client"
    }
  }
}

module "ssl-vpn" {
  source = "../../modules/ssl-vpn"

  for_each = local.ssl_map

  local_address       = try(each.value.local_address, null)
  remote_address      = try(each.value.remote_address, null)
  ssl_vpn_server_name = try(each.value.ssl_vpn_server_name, null)
  vpn_gateway_id      = try(each.value.vpn_gateway_id, null)
  ssl_vpn_protocol    = try(each.value.ssl_vpn_protocol, null)
  ssl_vpn_port        = try(each.value.ssl_vpn_port, null)
  integrity_algorithm = try(each.value.integrity_algorithm, null)
  encrypt_algorithm   = try(each.value.encrypt_algorithm, null)
  compress            = try(each.value.compress, null)
  ssl_vpn_client_name = try(each.value.ssl_vpn_client_name, null)
}