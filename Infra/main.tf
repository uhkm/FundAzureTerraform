terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.3.0" # Adjust the version as per your requirements
    }
  }
}

# Create a resource group
resource "azurerm_resource_group" "fund_resource_group" {
  name     = var.resource_group_name #"fundrg"
  location = var.location
}

# Creating a storage account
resource "azurerm_storage_account" "fund_storage_account" {
  name                     = var.storage_account_name #"fundsac"
  resource_group_name      = azurerm_resource_group.fund_resource_group.name
  location                 = azurerm_resource_group.fund_resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  static_website {
    index_document = "index.html"
  }

  tags = {
    environment = "dev"
  }
}

resource "azurerm_storage_blob" "fund_storage_blob" {
  name                   = var.index_document #"index.html"
  storage_account_name   = azurerm_storage_account.fund_storage_account.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source_content         = var.source_content #"<h1> Hola !! this is a static website deployed using Terraform </h1>"
}
