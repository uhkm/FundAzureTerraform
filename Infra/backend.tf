terraform {
  backend "azurerm" {
    resource_group_name  = "tfstaterguhk1"
    storage_account_name = "tfstatesauhk1"
    container_name       = "tfstatecontaineruhk1"
    key                  = "terraform.tfstate"
  }
}