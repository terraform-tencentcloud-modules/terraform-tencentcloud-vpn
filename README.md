# terraform-tencentcloud-vpn
Terraform module which creates VPN resources on TencentCloud

## Usage

```hcl
module "ccn" {
  source = "terraform-tencentcloud-modules/vpn/tencentcloud"

  vpn_gateway_name = "ccn_test"
  vpc_id           = "xxxxxxxx"
  type             = "SSL"
  zone             = "ap-guangzhou-3"
  bandwidth        = 5
  vpn_tags = {
    createdBy = "terraform"
  }
}
```

## Examples

- [Simple VPN](https://github.com/terraform-tencentcloud-modules/terraform-tencentcloud-vpn/tree/master/examples/simple-vpn)
  
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
| [tencentcloud_vpn_gateway.gateway](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/vpn_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bandwidth"></a> [bandwidth](#input\_bandwidth) | The maximum public network output bandwidth of VPN gateway (unit: Mbps), the available values include: 5,10,20,50,100,200,500,1000. Default is 5. When charge type is PREPAID, bandwidth degradation operation is unsupported. | `number` | n/a | yes |
| <a name="input_charge_type"></a> [charge\_type](#input\_charge\_type) | Charge Type of the VPN gateway. Valid value: PREPAID, POSTPAID\_BY\_HOUR. The default is POSTPAID\_BY\_HOUR. | `string` | `"POSTPAID_BY_HOUR"` | no |
| <a name="input_create_vpn_gateway"></a> [create\_vpn\_gateway](#input\_create\_vpn\_gateway) | Controls if VPN Gateway should be created (it affects almost all resources). | `bool` | `true` | no |
| <a name="input_max_connection"></a> [max\_connection](#input\_max\_connection) | Maximum number of connected clients allowed for the SSL VPN gateway. Valid values: [5, 10, 20, 50, 100]. This parameter is only required for SSL VPN gateways. | `number` | n/a | yes |
| <a name="input_prepaid_period"></a> [prepaid\_period](#input\_prepaid\_period) | Period of instance to be prepaid. Valid value: 1, 2, 3, 4, 6, 7, 8, 9, 12, 24, 36. The unit is month. Caution: when this para and renew\_flag para are valid, the request means to renew several months more pre-paid period. This para can only be changed on IPSEC vpn gateway. | `number` | n/a | yes |
| <a name="input_prepaid_renew_flag"></a> [prepaid\_renew\_flag](#input\_prepaid\_renew\_flag) | Flag indicates whether to renew or not. Valid value: NOTIFY\_AND\_AUTO\_RENEW, NOTIFY\_AND\_MANUAL\_RENEW. | `string` | n/a | yes |
| <a name="input_type"></a> [type](#input\_type) | Type of gateway instance, Default is IPSEC. Valid value: IPSEC, SSL, CCN and SSL\_CCN. | `string` | `"IPSEC"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC. Required if vpn gateway is not in CCN or SSL\_CCN type, and doesn't make sense for CCN or SSL\_CCN vpn gateway. | `string` | `"null"` | no |
| <a name="input_vpn_gateway_name"></a> [vpn\_gateway\_name](#input\_vpn\_gateway\_name) | Name of the VPN gateway. The length of character is limited to 1-60. | `string` | n/a | yes |
| <a name="input_vpn_tags"></a> [vpn\_tags](#input\_vpn\_tags) | Tags of the VPN Gateway to be created. | `map(string)` | `{}` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | Zone of the VPN gateway. | `string` | `"ap-guangzhou-3"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ccn_id"></a> [ccn\_id](#output\_ccn\_id) | The Id of VPN Gateway. |
<!-- END_TF_DOCS -->
