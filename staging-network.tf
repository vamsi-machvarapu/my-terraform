resource "azurerm_virtual_network" "staging-network" {
  name = var.vnet_name
  resource_group_name = var.resource_group_name
  location = var.region
  address_space = var.virtual_network_address_space
  depends_on = [
    azurerm_resource_group.staging-grp
  ]
}