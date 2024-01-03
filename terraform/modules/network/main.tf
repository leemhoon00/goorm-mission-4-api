terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}

data "aws_region" "current" {}

resource "aws_subnet" "public" {
  availability_zone = "${data.aws_region.current.name}${var.availability_zone}"
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.${var.index * 3}.0/24"
}

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
  route {
    cidr_block = var.vpc_cidr_block
    gateway_id = "local"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "public" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id
}

resource "aws_subnet" "server" {
  availability_zone = "${data.aws_region.current.name}${var.availability_zone}"
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.${var.index * 3 + 1}.0/24"
}

resource "aws_route_table" "server" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.vpc_cidr_block
    gateway_id = "local"
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public.id
  }
}

resource "aws_route_table_association" "server" {
  subnet_id      = aws_subnet.server.id
  route_table_id = aws_route_table.server.id
}

resource "aws_subnet" "database" {
  availability_zone = "${data.aws_region.current.name}${var.availability_zone}"
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.${var.index * 3 + 2}.0/24"
}

resource "aws_route_table" "database" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.vpc_cidr_block
    gateway_id = "local"
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public.id
  }
}

resource "aws_route_table_association" "database" {
  subnet_id      = aws_subnet.database.id
  route_table_id = aws_route_table.database.id
}
