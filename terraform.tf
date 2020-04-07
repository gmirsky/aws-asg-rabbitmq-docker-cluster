terraform {
  required_version = ">= 0.12"
  backend "local" {
    path = "./tfstate/terraform.tfstate"
  }
  #experiments      = [variable_validation]
  # backend "azurerm" {
  #   storage_account_name = "terraform_storage"
  #   container_name       = "terraform-remote-state-container"
  #   key                  = "rabbitmq/terraform.tfstate"
  #   resource_group_name  = "terraform_rg"
  #}
}
