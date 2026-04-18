variable "resource_group_name" {
  description = "Nom du resource group Azure"
  type        = string
  default     = "rg-datalake-dev"
}

variable "location" {
  description = "Region Azure"
  type        = string
  default     = "West Europe"
}

variable "storage_account_name" {
  description = "Nom du storage account (3-24 chars, lowercase, unique global)"
  type        = string
  default     = "stdatalakemamaddev"
}
