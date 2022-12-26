resource "azurerm_subnet" "subnet_names" {
  for_each = var.subnet_names
  name = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = [ each.value ] #[cidrsubnet(var.virtual_network_address_space,8,0)]
  depends_on = [
    azurerm_virtual_network.staging-network
  ]
}

