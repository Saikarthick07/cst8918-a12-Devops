provider "azurerm" {
  features {}
  subscription_id = "b8f4d954-1b62-49d7-800a-57d856397796"
}

resource "azurerm_resource_group" "tfstate" {
  name     = "tfstate-rg"
  location = "East US"
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "tfstate${random_id.suffix.hex}"
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}

resource "random_id" "suffix" {
  byte_length = 4
}
