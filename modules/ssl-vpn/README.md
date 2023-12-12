# terraform-tencentcloud-vpn
Terraform module which creates VPN ipsec resources on TencentCloud

## Usage

```hcl
module "ssl-vpn" {
  source = "terraform-tencentcloud-modules/vpn/tencentcloud//modules/ssl-vpn"

  local_address = [
    "10.0.0.0/17",
  ]
  remote_address      = "11.0.0.0/16"
  ssl_vpn_server_name = "ssl_server"
  vpn_gateway_id      = "vpngw-xxxxxx"
  ssl_vpn_protocol    = "UDP"
  ssl_vpn_port        = 1194
  integrity_algorithm = "MD5"
  encrypt_algorithm   = "AES-128-CBC"
  compress            = true

  ssl_vpn_client_name = "ssl_client"
}
```
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
| [tencentcloud_vpn_ssl_client.client](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/vpn_ssl_client) | resource |
| [tencentcloud_vpn_ssl_server.server](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/vpn_ssl_server) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compress"></a> [compress](#input\_compress) | If need compressed. Default value: False. | `bool` | n/a | yes |
| <a name="input_encrypt_algorithm"></a> [encrypt\_algorithm](#input\_encrypt\_algorithm) | The encrypt algorithm. Valid values: AES-128-CBC, AES-192-CBC, AES-256-CBC, NONE.Default value: NONE. | `string` | n/a | yes |
| <a name="input_integrity_algorithm"></a> [integrity\_algorithm](#input\_integrity\_algorithm) | The integrity algorithm. Valid values: SHA1, MD5 and NONE. Default value: NONE. | `string` | n/a | yes |
| <a name="input_local_address"></a> [local\_address](#input\_local\_address) | List of local CIDR. | `list(string)` | n/a | yes |
| <a name="input_remote_address"></a> [remote\_address](#input\_remote\_address) | Remote CIDR for client. | `string` | n/a | yes |
| <a name="input_ssl_vpn_client_name"></a> [ssl\_vpn\_client\_name](#input\_ssl\_vpn\_client\_name) | VPN gateway ID. | `string` | n/a | yes |
| <a name="input_ssl_vpn_port"></a> [ssl\_vpn\_port](#input\_ssl\_vpn\_port) | The port of ssl vpn. Default value: 1194. | `string` | n/a | yes |
| <a name="input_ssl_vpn_protocol"></a> [ssl\_vpn\_protocol](#input\_ssl\_vpn\_protocol) | The protocol of ssl vpn. Default value: UDP. | `string` | n/a | yes |
| <a name="input_ssl_vpn_server_name"></a> [ssl\_vpn\_server\_name](#input\_ssl\_vpn\_server\_name) | The name of ssl vpn server to be created. | `string` | n/a | yes |
| <a name="input_vpn_gateway_id"></a> [vpn\_gateway\_id](#input\_vpn\_gateway\_id) | VPN gateway ID. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vpn_ssl_client_id"></a> [vpn\_ssl\_client\_id](#output\_vpn\_ssl\_client\_id) | The Id of VPN SSL Client. |
| <a name="output_vpn_ssl_server_id"></a> [vpn\_ssl\_server\_id](#output\_vpn\_ssl\_server\_id) | The Id of VPN SSL Server. |
<!-- END_TF_DOCS -->

## Authors

Created and maintained by [TencentCloud](https://github.com/terraform-providers/terraform-provider-tencentcloud)

## License

Mozilla Public License Version 2.0.
See LICENSE for full details.

## Authors

Created and maintained by [TencentCloud](https://github.com/terraform-providers/terraform-provider-tencentcloud)

## License

Mozilla Public License Version 2.0.
See LICENSE for full details.
