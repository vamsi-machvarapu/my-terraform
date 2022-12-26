resource "azurerm_resource_group" "staging-grp" {
  name = var.resource_group_name
  location = var.region
}