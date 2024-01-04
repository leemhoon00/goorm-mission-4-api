// PUBLIC SUBNETS
resource "aws_subnet" "public_a" {
  availability_zone = "ap-northeast-2a"
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/24"
}
resource "aws_subnet" "public_b" {
  availability_zone = "ap-northeast-2b"
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = aws_vpc.main.cidr_block
    gateway_id = "local"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}
resource "aws_eip" "nat_a" {
  domain = "vpc"
}
resource "aws_eip" "nat_b" {
  domain = "vpc"
}
resource "aws_nat_gateway" "public_a" {
  allocation_id = aws_eip.nat_a.id
  subnet_id     = aws_subnet.public_a.id
}
resource "aws_nat_gateway" "public_b" {
  allocation_id = aws_eip.nat_b.id
  subnet_id     = aws_subnet.public_b.id
}


// SERVER PRIVATE SUBNETS
resource "aws_subnet" "server_a" {
  availability_zone = "ap-northeast-2a"
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
}
resource "aws_subnet" "server_b" {
  availability_zone = "ap-northeast-2b"
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
}
resource "aws_route_table" "server_a" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = aws_vpc.main.cidr_block
    gateway_id = "local"
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public_a.id
  }
}
resource "aws_route_table" "server_b" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = aws_vpc.main.cidr_block
    gateway_id = "local"
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public_b.id
  }
}
resource "aws_route_table_association" "server_a" {
  subnet_id      = aws_subnet.server_a.id
  route_table_id = aws_route_table.server_a.id
}
resource "aws_route_table_association" "server_b" {
  subnet_id      = aws_subnet.server_b.id
  route_table_id = aws_route_table.server_b.id
}


// DATABASE PRIVATE SUBNETS
resource "aws_subnet" "database_a" {
  availability_zone = "ap-northeast-2a"
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.4.0/24"
}
resource "aws_subnet" "database_b" {
  availability_zone = "ap-northeast-2b"
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.5.0/24"
}
resource "aws_route_table" "database_a" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = aws_vpc.main.cidr_block
    gateway_id = "local"
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public_a.id
  }
}
resource "aws_route_table" "database_b" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = aws_vpc.main.cidr_block
    gateway_id = "local"
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public_b.id
  }
}

resource "aws_route_table_association" "database_a" {
  subnet_id      = aws_subnet.database_a.id
  route_table_id = aws_route_table.database_a.id
}
resource "aws_route_table_association" "database_b" {
  subnet_id      = aws_subnet.database_b.id
  route_table_id = aws_route_table.database_b.id
}
