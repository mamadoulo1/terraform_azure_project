terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "stterraformstate2026ml"
    container_name       = "tfstate"
    key                  = "project_terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "data_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "data_lake" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.data_rg.name
  location                 = azurerm_resource_group.data_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true
}

resource "azurerm_storage_container" "raw" {
  name                  = "raw"
  storage_account_name  = azurerm_storage_account.data_lake.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "processed" {
  name                  = "processed"
  storage_account_name  = azurerm_storage_account.data_lake.name
  container_access_type = "private"
}
