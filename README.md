# az-managedmssql-tf

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.20 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.75.0 |
| <a name="provider_azurerm.logs"></a> [azurerm.logs](#provider\_azurerm.logs) | 3.75.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_monitor_diagnostic_setting.sql_server_diagnostics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_mssql_managed_database.sql_db](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_managed_database) | resource |
| [azurerm_mssql_managed_instance.sql_server](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_managed_instance) | resource |
| [azurerm_mssql_managed_instance_active_directory_administrator.sql_admin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_managed_instance_active_directory_administrator) | resource |
| [azurerm_mssql_managed_instance_security_alert_policy.alert_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_managed_instance_security_alert_policy) | resource |
| [azurerm_mssql_managed_instance_vulnerability_assessment.vuln_assess](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_managed_instance_vulnerability_assessment) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_log_analytics_workspace.logs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_storage_account.monitor_storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_administrator_login"></a> [administrator\_login](#input\_administrator\_login) | The user name of the admin for the SQL server | `string` | n/a | yes |
| <a name="input_administrator_login_password"></a> [administrator\_login\_password](#input\_administrator\_login\_password) | The password of the admin for the SQL server | `string` | n/a | yes |
| <a name="input_alert_policy"></a> [alert\_policy](#input\_alert\_policy) | SQL server extended audit policy | <pre>object({<br>    retention_days = optional(number, 0)<br>  })</pre> | `null` | no |
| <a name="input_azuread_authentication_only"></a> [azuread\_authentication\_only](#input\_azuread\_authentication\_only) | Only allow logins via Azure AD | `bool` | `true` | no |
| <a name="input_collation"></a> [collation](#input\_collation) | Collation for SQL server | `string` | `"SQL_Latin1_General_CP1_CI_AS"` | no |
| <a name="input_databases"></a> [databases](#input\_databases) | Databases for the sql server | <pre>list(object({<br>    name                           = string<br>    auto_pause_delay_in_minutes    = optional(number)<br>    create_mode                    = optional(string, "Default")<br>    creation_source_database_id    = optional(string)<br>    elastic_pool_reference         = optional(string)<br>    geo_backup_enabled             = optional(bool, true)<br>    maintenance_configuration_name = optional(string, "SQL_Default")<br>    ledger_enabled                 = optional(bool, false)<br>    min_capacity                   = optional(number)<br>    restore_point_in_time          = optional(string)<br>    recover_database_id            = optional(string)<br>    restore_dropped_database_id    = optional(string)<br>    read_replica_count             = optional(number)<br>    sample_name                    = optional(string)<br>    sku_name                       = string<br>    storage_account_type           = optional(string, "Geo")<br>    collation                      = optional(string, "SQL_Latin1_General_CP1_CI_AS")<br>    license_type                   = optional(string, "LicenseIncluded")<br>    max_size_gb                    = optional(number)<br>    read_scale                     = optional(bool, false)<br>    zone_redundant                 = bool<br>    import = optional(list(object({<br>      storage_account_name                = string<br>      storage_account_resource_group_name = string<br>      administrator_login                 = string<br>      authentication_type                 = optional(string, "ADPassword")<br>    })))<br>    long_term_retention_policy = object({<br>      weekly_retention  = optional(string)<br>      monthly_retention = optional(string)<br>      yearly_retention  = optional(string)<br>      week_of_year      = optional(string)<br>    })<br>    short_term_retention_policy = object({<br>      retention_days           = number<br>      backup_interval_in_hours = optional(number, 12)<br>    })<br>  }))</pre> | `[]` | no |
| <a name="input_dns_zone_partner_id"></a> [dns\_zone\_partner\_id](#input\_dns\_zone\_partner\_id) | The ID of the SQL Managed Instance which will share the DNS zone. | `string` | `null` | no |
| <a name="input_email_addresses"></a> [email\_addresses](#input\_email\_addresses) | Additional email addresses for alerts | `list(string)` | n/a | yes |
| <a name="input_license_type"></a> [license\_type](#input\_license\_type) | License pricing for the SQL server | `string` | `"LicenseIncluded"` | no |
| <a name="input_location"></a> [location](#input\_location) | The location of the sql server | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Name of Log Analytics Workspace to send diagnostics | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | Resource Group of Log Analytics Workspace to send diagnostics | `string` | n/a | yes |
| <a name="input_maintenance_configuration_name"></a> [maintenance\_configuration\_name](#input\_maintenance\_configuration\_name) | Patching schedule of the SQL server | `string` | `"SQL_Default"` | no |
| <a name="input_monitor_storage_account"></a> [monitor\_storage\_account](#input\_monitor\_storage\_account) | SQL server extended audit policy | <pre>object({<br>    name                = string<br>    resource_group_name = string<br>    container_name      = string<br>  })</pre> | `null` | no |
| <a name="input_proxy_override"></a> [proxy\_override](#input\_proxy\_override) | How to access the SQL server | `string` | `"Default"` | no |
| <a name="input_public_data_endpoint_enabled"></a> [public\_data\_endpoint\_enabled](#input\_public\_data\_endpoint\_enabled) | Enable public access | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group to deploy the sql server to | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | Sku of the SQL server | `string` | n/a | yes |
| <a name="input_sql_admin"></a> [sql\_admin](#input\_sql\_admin) | Azure AD SQL admin | <pre>object({<br>    username  = string<br>    object_id = string<br>  })</pre> | n/a | yes |
| <a name="input_sql_server_name"></a> [sql\_server\_name](#input\_sql\_server\_name) | The name of the sql server to deploy | `string` | n/a | yes |
| <a name="input_storage_account_type"></a> [storage\_account\_type](#input\_storage\_account\_type) | Storage account type for backups | `string` | `"GRS"` | no |
| <a name="input_storage_size_in_gb"></a> [storage\_size\_in\_gb](#input\_storage\_size\_in\_gb) | Storage available for SQL server (multiples of 32) | `number` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet ID to deploy SQL server to | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply | `map(string)` | n/a | yes |
| <a name="input_timezone_id"></a> [timezone\_id](#input\_timezone\_id) | Timezone of the SQL server | `string` | n/a | yes |
| <a name="input_vcores"></a> [vcores](#input\_vcores) | Number of vcores for SQL server | `number` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->