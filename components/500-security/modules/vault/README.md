<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_oci"></a> [oci](#requirement\_oci) | 6.25.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | 6.25.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [oci_kms_key.this](https://registry.terraform.io/providers/oracle/oci/6.25.0/docs/resources/kms_key) | resource |
| [oci_kms_vault.this](https://registry.terraform.io/providers/oracle/oci/6.25.0/docs/resources/kms_vault) | resource |
| [oci_vault_secret.this_plaintext](https://registry.terraform.io/providers/oracle/oci/6.25.0/docs/resources/vault_secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_compartment_id"></a> [compartment\_id](#input\_compartment\_id) | The compartment id where the vault should be created | `string` | n/a | yes |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | A map of secrets to create. The key will be used as the secret\_name and the value will be the secret's content (in BASE64). | `map(string)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the resources | `map(string)` | `{}` | no |
| <a name="input_vault_name"></a> [vault\_name](#input\_vault\_name) | The name of the vault | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kms_key_id"></a> [kms\_key\_id](#output\_kms\_key\_id) | The OCID of the master encryption key in the vault. |
| <a name="output_vault_id"></a> [vault\_id](#output\_vault\_id) | The OCID of the vault. |
<!-- END_TF_DOCS -->