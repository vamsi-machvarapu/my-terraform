terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.35.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "storage_tfstatefile"
    storage_account_name = "storagetfstatefiles01"
    container_name = "tfcontainer"
    key = "terraform.tfstate"
  }
}

provider "azurerm" {
  # Configuration options
  features {}
  client_id = "52b3cc4b-6b46-4ff9-94bc-9fb15443ab1f"
  subscription_id = "2bc1a6d2-485b-451a-b408-db871cbcb616"
  tenant_id = "cb2c3ee5-d8c1-450f-93bc-fe15b50fc45e"
  client_secret = "uDF8Q~EXZwTEPgYfOWjFCLFUjSUilfJQ21KCxayg"
}