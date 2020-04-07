provider "aws" {
  version = "~> 2.0"
  region  = var.region
}

provider "azurerm" {
  version = "2.0.0"
}

provider "random" {
  version = "~> 2.2"
}

provider "null" {
  version = "~> 2.1"
}

provider "template" {
  version = "~> 2.1"
}

