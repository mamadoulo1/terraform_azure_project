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
  name     = "rg-datalake-dev"
  location = "West Europe"
}

module "datalake_dev" {
  source = "./modules/datalake"

  storage_account_name = "stdatalakemamaddev"
  resource_group_name  = azurerm_resource_group.data_rg.name
  location             = azurerm_resource_group.data_rg.location
}

module "datalake_prod" {
  source = "./modules/datalake"

  storage_account_name = "stdatalakemamadprod"
  resource_group_name  = azurerm_resource_group.data_rg.name
  location             = azurerm_resource_group.data_rg.location
}
