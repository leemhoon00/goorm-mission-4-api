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
