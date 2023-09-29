data "azurerm_client_config" "current" {}

data "azurerm_storage_account" "monitor_storage_account" {
  provider            = azurerm.logs
  name                = var.monitor_storage_account.name
  resource_group_name = var.monitor_storage_account.resource_group_name
}

data "azurerm_log_analytics_workspace" "logs" {
  provider            = azurerm.logs
  name                = var.log_analytics_workspace_name
  resource_group_name = var.log_analytics_workspace_resource_group_name
}
