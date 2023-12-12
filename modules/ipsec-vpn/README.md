# terraform-tencentcloud-vpn
Terraform module which creates VPN ipsec resources on TencentCloud

## Usage

```hcl
module "ipsec-vpn" {
  source = "terraform-tencentcloud-modules/vpn/tencentcloud//modules/ipsec-vpn"


  customer_gateway_name    = "ipec_customer_gateway"
  customer_gateway_address = "1.1.1.1"
  customer_gateway_tags    = {
    tag = "test"
  }

  vpc_id             = "xxxxxx"
  connection_name    = "connection_ipec"
  ike_local_address  = "81.71.18.160"
  ike_remote_address = "1.1.1.1"
  vpn_gateway_id     = "xxxxxx"
  spd_policy         = [
    {
      local_cidr_block   = "172.16.0.0/16"
      remote_cidr_blocks = "2.2.2.0/26"
    }
  ]
}
```

## Examples

- [Simple VPN](https://github.com/terraform-tencentcloud-modules/terraform-tencentcloud-vpn/tree/master/examples/ipsec-vpn)
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.12 |
| <a name="requirement_tencentcloud"></a> [tencentcloud](#requirement\_tencentcloud) | >=1.81.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tencentcloud"></a> [tencentcloud](#provider\_tencentcloud) | >=1.81.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tencentcloud_vpn_connection.connection](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/vpn_connection) | resource |
| [tencentcloud_vpn_customer_gateway.customer_gateway](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/vpn_customer_gateway) | resource |
| [tencentcloud_vpn_gateway_route.vpn_gateway_route](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/vpn_gateway_route) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_connection_name"></a> [connection\_name](#input\_connection\_name) | Name of the VPN connection. The length of character is limited to 1-60. | `string` | n/a | yes |
| <a name="input_customer_gateway_address"></a> [customer\_gateway\_address](#input\_customer\_gateway\_address) | Public IP of the customer gateway. | `string` | n/a | yes |
| <a name="input_customer_gateway_name"></a> [customer\_gateway\_name](#input\_customer\_gateway\_name) | Name of the customer gateway. The length of character is limited to 1-60. | `string` | n/a | yes |
| <a name="input_customer_gateway_tags"></a> [customer\_gateway\_tags](#input\_customer\_gateway\_tags) | A list of tags used to associate customer gateway. | `map(string)` | `{}` | no |
| <a name="input_destination_cidr_block"></a> [destination\_cidr\_block](#input\_destination\_cidr\_block) | Destination IDC IP range. | `string` | `"192.168.0.0/24"` | no |
| <a name="input_dpd_action"></a> [dpd\_action](#input\_dpd\_action) | The action after DPD timeout. Valid values: clear (disconnect) and restart (try again). It is valid when DpdEnable is 1. | `string` | `"restart"` | no |
| <a name="input_dpd_enable"></a> [dpd\_enable](#input\_dpd\_enable) | Specifies whether to enable DPD. Valid values: 0 (disable) and 1 (enable). | `number` | `1` | no |
| <a name="input_dpd_timeout"></a> [dpd\_timeout](#input\_dpd\_timeout) | DPD timeout period.Valid value ranges: [30~60], Default: 30; unit: second. If the request is not responded within this period, the peer end is considered not exists. This parameter is valid when the value of DpdEnable is 1. | `number` | `30` | no |
| <a name="input_enable_health_check"></a> [enable\_health\_check](#input\_enable\_health\_check) | Whether intra-tunnel health checks are supported. | `bool` | `false` | no |
| <a name="input_health_check_local_ip"></a> [health\_check\_local\_ip](#input\_health\_check\_local\_ip) | Health check the address of this terminal. | `string` | `null` | no |
| <a name="input_health_check_remote_ip"></a> [health\_check\_remote\_ip](#input\_health\_check\_remote\_ip) | Health check peer address. | `string` | `null` | no |
| <a name="input_ike_dh_group_name"></a> [ike\_dh\_group\_name](#input\_ike\_dh\_group\_name) | DH group name of the IKE operation specification. Valid values: GROUP1, GROUP2, GROUP5, GROUP14, GROUP24. Default value is GROUP1. | `string` | `"GROUP2"` | no |
| <a name="input_ike_exchange_mode"></a> [ike\_exchange\_mode](#input\_ike\_exchange\_mode) | Exchange mode of the IKE operation specification. Valid values: AGGRESSIVE, MAIN. Default value is MAIN. | `string` | `"AGGRESSIVE"` | no |
| <a name="input_ike_local_address"></a> [ike\_local\_address](#input\_ike\_local\_address) | Local address of IKE operation specification, valid when ike\_local\_identity is ADDRESS, generally the value is public\_ip\_address of the related VPN gateway. | `string` | n/a | yes |
| <a name="input_ike_local_identity"></a> [ike\_local\_identity](#input\_ike\_local\_identity) | Local identity way of IKE operation specification. Valid values: ADDRESS, FQDN. Default value is ADDRESS. | `string` | `"ADDRESS"` | no |
| <a name="input_ike_proto_authen_algorithm"></a> [ike\_proto\_authen\_algorithm](#input\_ike\_proto\_authen\_algorithm) | Proto authenticate algorithm of the IKE operation specification. Valid values: MD5, SHA, SHA-256. Default Value is MD5. | `string` | `"SHA"` | no |
| <a name="input_ike_proto_encry_algorithm"></a> [ike\_proto\_encry\_algorithm](#input\_ike\_proto\_encry\_algorithm) | Proto encrypt algorithm of the IKE operation specification. Valid values: 3DES-CBC, AES-CBC-128, AES-CBC-192, AES-CBC-256, DES-CBC, SM4, AES128GCM128, AES192GCM128, AES256GCM128,AES128GCM128, AES192GCM128, AES256GCM128. Default value is 3DES-CBC. | `string` | `"3DES-CBC"` | no |
| <a name="input_ike_remote_address"></a> [ike\_remote\_address](#input\_ike\_remote\_address) | Remote address of IKE operation specification, valid when ike\_remote\_identity is ADDRESS, generally the value is public\_ip\_address of the related customer gateway. | `string` | `null` | no |
| <a name="input_ike_remote_identity"></a> [ike\_remote\_identity](#input\_ike\_remote\_identity) | Remote identity way of IKE operation specification. Valid values: ADDRESS, FQDN. Default value is ADDRESS. | `string` | `"ADDRESS"` | no |
| <a name="input_ike_sa_lifetime_seconds"></a> [ike\_sa\_lifetime\_seconds](#input\_ike\_sa\_lifetime\_seconds) | SA lifetime of the IKE operation specification, unit is second. The value ranges from 60 to 604800. Default value is 86400 seconds. | `number` | `86400` | no |
| <a name="input_ike_version"></a> [ike\_version](#input\_ike\_version) | Version of the IKE operation specification, values: IKEV1, IKEV2. Default value is IKEV1. | `string` | `"IKEV1"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Next hop type (type of the associated instance). Valid values: VPNCONN (VPN tunnel) and CCN (CCN instance). | `string` | `"VPNCONN"` | no |
| <a name="input_ipsec_encrypt_algorithm"></a> [ipsec\_encrypt\_algorithm](#input\_ipsec\_encrypt\_algorithm) | Encrypt algorithm of the IPSEC operation specification. Valid values: 3DES-CBC, AES-CBC-128, AES-CBC-192, AES-CBC-256, DES-CBC, SM4, NULL, AES128GCM128, AES192GCM128, AES256GCM128. Default value is 3DES-CBC. | `string` | `"3DES-CBC"` | no |
| <a name="input_ipsec_integrity_algorithm"></a> [ipsec\_integrity\_algorithm](#input\_ipsec\_integrity\_algorithm) | Integrity algorithm of the IPSEC operation specification. Valid values: SHA1, MD5, SHA-256. Default value is MD5. | `string` | `"MD5"` | no |
| <a name="input_ipsec_pfs_dh_group"></a> [ipsec\_pfs\_dh\_group](#input\_ipsec\_pfs\_dh\_group) | PFS DH group. Valid value: GROUP1, GROUP2, GROUP5, GROUP14, GROUP24, NULL. Default value is NULL. | `string` | `null` | no |
| <a name="input_ipsec_sa_lifetime_seconds"></a> [ipsec\_sa\_lifetime\_seconds](#input\_ipsec\_sa\_lifetime\_seconds) | SA lifetime of the IPSEC operation specification, unit is second. Valid value ranges: [180~604800]. Default value is 3600 seconds. | `number` | `"3600"` | no |
| <a name="input_ipsec_sa_lifetime_traffic"></a> [ipsec\_sa\_lifetime\_traffic](#input\_ipsec\_sa\_lifetime\_traffic) | SA lifetime of the IPSEC operation specification, unit is second. Valid value ranges: [180~604800]. Default value is 3600 seconds. | `number` | `"2560"` | no |
| <a name="input_pre_share_key"></a> [pre\_share\_key](#input\_pre\_share\_key) | Pre-shared key of the VPN connection. | `string` | `"test"` | no |
| <a name="input_route_priority"></a> [route\_priority](#input\_route\_priority) | Priority. Valid values: 0 and 100. | `number` | `100` | no |
| <a name="input_route_status"></a> [route\_status](#input\_route\_status) | Whether routing information is enabled. ENABLE: Enable Route, DISABLE: Disable Route. | `string` | `"ENABLE"` | no |
| <a name="input_spd_policy"></a> [spd\_policy](#input\_spd\_policy) | Security group policy of the VPN connection. | `list(map(string))` | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC. Required if vpn gateway is not in CCN type, and doesn't make sense for CCN vpn gateway. | `string` | n/a | yes |
| <a name="input_vpn_connection_tags"></a> [vpn\_connection\_tags](#input\_vpn\_connection\_tags) | A list of tags used to associate vpn connection. | `map(string)` | `{}` | no |
| <a name="input_vpn_gateway_id"></a> [vpn\_gateway\_id](#input\_vpn\_gateway\_id) | ID of the VPN gateway. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpn_connection_id"></a> [vpn\_connection\_id](#output\_vpn\_connection\_id) | The Id of VPN Connnection. |
| <a name="output_vpn_customer_gateway_id"></a> [vpn\_customer\_gateway\_id](#output\_vpn\_customer\_gateway\_id) | The Id of VPN customer gateway. |
| <a name="output_vpn_gateway_route"></a> [vpn\_gateway\_route](#output\_vpn\_gateway\_route) | The Id of VPN Route. |
<!-- END_TF_DOCS -->

## Authors

Created and maintained by [TencentCloud](https://github.com/terraform-providers/terraform-provider-tencentcloud)

## License

Mozilla Public License Version 2.0.
See LICENSE for full details.
