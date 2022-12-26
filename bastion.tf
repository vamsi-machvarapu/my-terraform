resource "azurerm_public_ip" "bastionip" {
  name                = "bastionpip"
  location            = var.region
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  depends_on = [
    azurerm_resource_group.staging-grp
  ]
}

data "azurerm_subnet" "bastion_subnet_id" {
  name                 = "AzureBastionSubnet"
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
  depends_on = [
    azurerm_resource_group.staging-grp,
    azurerm_virtual_network.staging-network
  ]
}

output "subnet_id" {
  value = data.azurerm_subnet.bastion_subnet_id.id
}

resource "azurerm_bastion_host" "bastion_jump_server" {
  name                = "bastion_jump_server"
  location            = var.region
  resource_group_name = var.resource_group_name
  depends_on = [
    azurerm_resource_group.staging-grp,
    azurerm_subnet.subnet_names,
    azurerm_public_ip.bastionip
  ]

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.bastion_subnet_id.id
    public_ip_address_id = azurerm_public_ip.bastionip.id
  }
}