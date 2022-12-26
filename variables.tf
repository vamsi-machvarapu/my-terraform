variable "resource_group_name" {
  description = "staging resource group"
  type = string
  default = "staging-grp"
}

variable "region" {
  description = "location of the infra"
  type = string
  default = null
}

variable "vnet_name" {
  description = "Infra networking"
  type = string
  default = null
  
}

variable "virtual_network_address_space" {
  type = list(string)
  default = [ "10.0.0.0/16" ]
 
}

variable "subnet_names" {
  type = map
  default = {
    web-subnet = "10.0.1.0/24"
    db-subnet = "10.0.3.0/24"
    AzureBastionSubnet = "10.0.2.0/24"
  }

}

variable "nsg_names" {
  type = list(string)
  default = [ "web-nsg" , "db-nsg" , "bastion-nsg" ]
}
