# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

# Configurar el proveedor corrspondinte a Azure 
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.1"
    }
  }
}

# Configurar el service principal 
provider "azurerm" {
  features {}
  subscription_id = "fe7fc6a2-7789-4474-84f5-24f237707c09"
  client_id       = "78eefc64-cd0c-49e7-b5e3-15374e5d1263"
  client_secret   = "NtO98orFwcMZ-vj_wwVWYwxB6by22v34un"
  tenant_id       = "899789dc-202f-44b4-8472-a6d40f9eb440"
}


# Grupo de Recurso de Azure donde se instanciaran los recursos a Crear
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
resource "azurerm_resource_group" "rg" {
    name     =  "hdz_kubernetes_rg"
    location = var.location

    tags = {
        environment = "CP2"
    }

}

# Crear un Storage account para Guaradar Informaicon de Maquinas y 
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account

resource "azurerm_storage_account" "stAccount" {
    name                     = "hdzstaccountcp2" 
    resource_group_name      = azurerm_resource_group.rg.name
    location                 = azurerm_resource_group.rg.location
    account_tier             = "Standard"
    account_replication_type = "LRS"

    tags = {
        environment = "CP2"
    }
}
