terraform {
  cloud {
    organization = "leemhoon000"
    workspaces {
      name = "goorm-mission-4-api"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}

provider "aws" {}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

module "network" {
  for_each = toset(var.availability_zones)
  source   = "./modules/network"

  vpc_id              = aws_vpc.main.id
  vpc_cidr_block      = aws_vpc.main.cidr_block
  internet_gateway_id = aws_internet_gateway.main.id
  index               = index(var.availability_zones, each.value)
  availability_zone   = each.value
}

