provider "azurerm" {
  features {}
  subscription_id = "f9f71262-67c6-48a1-ad2f-75ed5b29135b"
}

resource "azurerm_resource_group" "imported" {
  name     = "new_resource"
  location = "israelcentral"
}
