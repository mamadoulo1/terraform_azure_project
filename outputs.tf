output "storage_account_name" {
  value = azurerm_storage_account.data_lake.name
}

output "primary_blob_endpoint" {
  value = azurerm_storage_account.data_lake.primary_blob_endpoint
}
