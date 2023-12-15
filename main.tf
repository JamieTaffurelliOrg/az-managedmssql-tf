resource "azurerm_mssql_managed_instance" "sql_server" {
  name                           = var.sql_server_name
  resource_group_name            = var.resource_group_name
  location                       = var.location
  administrator_login            = var.administrator_login
  administrator_login_password   = var.administrator_login_password
  license_type                   = var.license_type
  sku_name                       = var.sku_name
  storage_size_in_gb             = var.storage_size_in_gb
  subnet_id                      = var.subnet_id
  vcores                         = var.vcores
  collation                      = var.collation
  dns_zone_partner_id            = var.dns_zone_partner_id
  maintenance_configuration_name = var.maintenance_configuration_name
  proxy_override                 = var.proxy_override
  public_data_endpoint_enabled   = var.public_data_endpoint_enabled
  storage_account_type           = var.storage_account_type
  timezone_id                    = var.timezone_id
  minimum_tls_version            = "1.2"

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_monitor_diagnostic_setting" "sql_server_diagnostics" {
  name                       = "${var.log_analytics_workspace_name}-security-logging"
  target_resource_id         = azurerm_mssql_managed_instance.sql_server.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.logs.id

  enabled_log {
    category = "SQLInsights"
  }

  enabled_log {
    category = "QueryStoreRuntimeStatistics"
  }

  enabled_log {
    category = "QueryStoreWaitStatistics"
  }

  enabled_log {
    category = "Errors"
  }

  enabled_log {
    category = "ResourceUsageStatistics"
  }

  enabled_log {
    category = "DevopsOperationsAuditLogs"
  }

  enabled_log {
    category = "SQLSecurityAuditEvent"
  }

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}

resource "azurerm_mssql_managed_instance_active_directory_administrator" "sql_admin" {
  managed_instance_id         = azurerm_mssql_managed_instance.sql_server.id
  login_username              = var.sql_admin.username
  object_id                   = var.sql_admin.object_id
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  azuread_authentication_only = var.azuread_authentication_only
}

resource "azurerm_mssql_managed_instance_security_alert_policy" "alert_policy" {
  resource_group_name          = var.resource_group_name
  managed_instance_name        = azurerm_mssql_managed_instance.sql_server.name
  enabled                      = true
  storage_endpoint             = data.azurerm_storage_account.monitor_storage_account.primary_blob_endpoint
  storage_account_access_key   = data.azurerm_storage_account.monitor_storage_account.primary_access_key
  disabled_alerts              = []
  retention_days               = var.alert_policy.retention_days
  email_account_admins_enabled = true
  email_addresses              = var.email_addresses
}

resource "azurerm_mssql_managed_instance_vulnerability_assessment" "vuln_assess" {
  managed_instance_id        = azurerm_mssql_managed_instance.sql_server.id
  storage_container_path     = "${data.azurerm_storage_account.monitor_storage_account.primary_blob_endpoint}${var.monitor_storage_account.container_name}/"
  storage_account_access_key = data.azurerm_storage_account.monitor_storage_account.primary_access_key

  recurring_scans {
    enabled                   = true
    email_subscription_admins = true
    emails                    = var.email_addresses
  }
}

resource "azurerm_mssql_managed_database" "sql_db" {
  for_each            = { for k in var.databases : k.name => k if k != null }
  name                = each.key
  managed_instance_id = azurerm_mssql_managed_instance.sql_server.id

  long_term_retention_policy {
    weekly_retention  = each.value["long_term_retention_policy"].weekly_retention
    monthly_retention = each.value["long_term_retention_policy"].monthly_retention
    yearly_retention  = each.value["long_term_retention_policy"].yearly_retention
    week_of_year      = each.value["long_term_retention_policy"].week_of_year
  }

  short_term_retention_days = each.value["short_term_retention_policy"].retention_days
}
