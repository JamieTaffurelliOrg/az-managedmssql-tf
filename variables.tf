variable "sql_server_name" {
  type        = string
  description = "The name of the sql server to deploy"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group to deploy the sql server to"
}

variable "location" {
  type        = string
  description = "The location of the sql server"
}

variable "administrator_login" {
  type        = string
  description = "The user name of the admin for the SQL server"
}

variable "administrator_login_password" {
  type        = string
  sensitive   = true
  description = "The password of the admin for the SQL server"
}

variable "license_type" {
  type        = string
  default     = "LicenseIncluded"
  description = "License pricing for the SQL server"
}

variable "sku_name" {
  type        = string
  description = "Sku of the SQL server"
}

variable "storage_size_in_gb" {
  type        = number
  description = "Storage available for SQL server (multiples of 32)"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID to deploy SQL server to"
}

variable "vcores" {
  type        = number
  description = "Number of vcores for SQL server"
}

variable "collation" {
  type        = string
  default     = "SQL_Latin1_General_CP1_CI_AS"
  description = "Collation for SQL server"
}

variable "dns_zone_partner_id" {
  type        = string
  default     = null
  description = "The ID of the SQL Managed Instance which will share the DNS zone."
}

variable "maintenance_configuration_name" {
  type        = string
  default     = "SQL_Default"
  description = "Patching schedule of the SQL server"
}

variable "proxy_override" {
  type        = string
  default     = "Default"
  description = "How to access the SQL server"
}

variable "public_data_endpoint_enabled" {
  type        = bool
  default     = false
  description = "Enable public access"
}

variable "storage_account_type" {
  type        = string
  default     = "GRS"
  description = "Storage account type for backups"
}

variable "timezone_id" {
  type        = string
  description = "Timezone of the SQL server"
}

variable "azuread_authentication_only" {
  type        = bool
  default     = true
  description = "Only allow logins via Azure AD"
}

variable "sql_admin" {
  type = object({
    username  = string
    object_id = string
  })
  description = "Azure AD SQL admin"
}

variable "alert_policy" {
  type = object({
    retention_days = optional(number, 0)
  })
  default     = null
  description = "SQL server extended audit policy"
}

variable "databases" {
  type = list(object({
    name                           = string
    auto_pause_delay_in_minutes    = optional(number)
    create_mode                    = optional(string, "Default")
    creation_source_database_id    = optional(string)
    elastic_pool_reference         = optional(string)
    geo_backup_enabled             = optional(bool, true)
    maintenance_configuration_name = optional(string, "SQL_Default")
    ledger_enabled                 = optional(bool, false)
    min_capacity                   = optional(number)
    restore_point_in_time          = optional(string)
    recover_database_id            = optional(string)
    restore_dropped_database_id    = optional(string)
    read_replica_count             = optional(number)
    sample_name                    = optional(string)
    sku_name                       = string
    storage_account_type           = optional(string, "Geo")
    collation                      = optional(string, "SQL_Latin1_General_CP1_CI_AS")
    license_type                   = optional(string, "LicenseIncluded")
    max_size_gb                    = optional(number)
    read_scale                     = optional(bool, false)
    zone_redundant                 = bool
    import = optional(list(object({
      storage_account_name                = string
      storage_account_resource_group_name = string
      administrator_login                 = string
      authentication_type                 = optional(string, "ADPassword")
    })))
    long_term_retention_policy = object({
      weekly_retention  = optional(string)
      monthly_retention = optional(string)
      yearly_retention  = optional(string)
      week_of_year      = optional(string)
    })
    short_term_retention_policy = object({
      retention_days           = number
      backup_interval_in_hours = optional(number, 12)
    })
  }))
  default     = []
  description = "Databases for the sql server"
}

variable "email_addresses" {
  type        = list(string)
  description = "Additional email addresses for alerts"
}

variable "monitor_storage_account" {
  type = object({
    name                = string
    resource_group_name = string
    container_name      = string
  })
  default     = null
  description = "SQL server extended audit policy"
}

variable "log_analytics_workspace_name" {
  type        = string
  description = "Name of Log Analytics Workspace to send diagnostics"
}

variable "log_analytics_workspace_resource_group_name" {
  type        = string
  description = "Resource Group of Log Analytics Workspace to send diagnostics"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply"
}
