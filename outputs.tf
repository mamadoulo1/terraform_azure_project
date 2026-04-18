output "datalake_dev_endpoint" {
  value = module.datalake_dev.primary_blob_endpoint
}

output "datalake_prod_endpoint" {
  value = module.datalake_prod.primary_blob_endpoint
}
