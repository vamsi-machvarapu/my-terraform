resource "azurerm_network_security_group" "nsg" {
  count = length(var.nsg_names)
  name                = var.nsg_names[count.index]
  location            = var.region
  resource_group_name = var.resource_group_name
  
  depends_on = [
    azurerm_subnet.subnet_names
  ]
}

/*data "azurerm_subnet" "bastion_subnet_id" {
  name                 = "AzureBastionSubnet"
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
  depends_on = [
    azurerm_resource_group.staging-grp,
    azurerm_virtual_network.staging-network,
    azurerm_subnet.staging-subnet
  ]
}*/

data "azurerm_subnet" "web_subnet_id" {
  name                 = "web-subnet"
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
  depends_on = [
    azurerm_resource_group.staging-grp,
    azurerm_virtual_network.staging-network,
    azurerm_subnet.subnet_names
  ]
}

data "azurerm_subnet" "db_subnet_id" {
  name                 = "db-subnet"
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
  depends_on = [
    azurerm_resource_group.staging-grp,
    azurerm_virtual_network.staging-network,
    azurerm_subnet.subnet_names
  ]
}

/*output "subnet_id" {
  value = data.azurerm_subnet.bastion_subnet_id.id
}*/

output "web_subnet_id" {
  value = data.azurerm_subnet.web_subnet_id.id
}

output "db_subnet_id" {
  value = data.azurerm_subnet.db_subnet_id.id
}

data "azurerm_network_security_group" "bastion-nsg" {
  name                = "bastion-nsg"
  resource_group_name = var.resource_group_name
}

output "bastion-id" {
  value = data.azurerm_network_security_group.bastion-nsg.id
}

data "azurerm_network_security_group" "web-nsg" {
  name                = "web-nsg"
  resource_group_name = var.resource_group_name
}

output "web-id" {
  value = data.azurerm_network_security_group.web-nsg.id
}

data "azurerm_network_security_group" "db-nsg" {
  name                = "db-nsg"
  resource_group_name = var.resource_group_name
}

output "db-id" {
  value = data.azurerm_network_security_group.db-nsg.id
}



resource "azurerm_subnet_network_security_group_association" "nsg-associate-bastion" {
  subnet_id                 = data.azurerm_subnet.bastion_subnet_id.id
  network_security_group_id = data.azurerm_network_security_group.bastion-nsg.id
}

resource "azurerm_subnet_network_security_group_association" "nsg-associate-web" {
  for_each =  var.subnet_names
  subnet_id                 = data.azurerm_subnet.web_subnet_id.id
  network_security_group_id = data.azurerm_network_security_group.web-nsg.id
}

resource "azurerm_subnet_network_security_group_association" "nsg-associate-db" {
  for_each =  var.subnet_names
  subnet_id                 = data.azurerm_subnet.db_subnet_id.id
  network_security_group_id = data.azurerm_network_security_group.db-nsg.id
}



