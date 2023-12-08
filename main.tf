locals {
  create_vpn_gateway = var.create_vpn_gateway
}


################################################################################
# VPN Gateway
################################################################################
resource "tencentcloud_vpn_gateway" "gateway" {
  count              = local.create_vpn_gateway ? 1 : 0
  name               = var.vpn_gateway_name
  bandwidth          = var.bandwidth
  zone               = try(var.zone, null)
  type               = try(var.type, "IPSEC")
  vpc_id             = try(var.vpc_id, null)
  charge_type        = try(var.charge_type, "POSTPAID_BY_HOUR")
  prepaid_period     = try(var.charge_type, "POSTPAID_BY_HOUR") == "PREPAID" ? try(var.prepaid_period, 1) : null
  prepaid_renew_flag = try(var.charge_type, "POSTPAID_BY_HOUR") == "PREPAID" ? try(var.prepaid_renew_flag, "NOTIFY_AND_AUTO_RENEW") : null
  max_connection     = try(var.max_connection, null)
  tags               = var.vpn_tags
}
