resource "aws_db_subnet_group" "db" {
  name       = "db"
  subnet_ids = [aws_subnet.database_a.id, aws_subnet.database_b.id]
}

resource "aws_security_group" "db" {
  name        = "db"
  description = "allow all traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "db" {
  allocated_storage          = 10
  db_name                    = "postgres"
  engine                     = "postgres"
  engine_version             = "15.4"
  instance_class             = "db.t3.micro"
  password                   = "postgres"
  username                   = "postgres"
  skip_final_snapshot        = true
  db_subnet_group_name       = aws_db_subnet_group.db.name
  auto_minor_version_upgrade = false
  vpc_security_group_ids     = [aws_security_group.db.id]
  backup_retention_period    = 3
  availability_zone          = "ap-northeast-2a"
}

resource "aws_db_instance" "replica" {
  identifier                 = "replica"
  replicate_source_db        = aws_db_instance.db.identifier
  engine                     = "postgres"
  engine_version             = "15.4"
  instance_class             = "db.t3.micro"
  skip_final_snapshot        = true
  auto_minor_version_upgrade = false
  vpc_security_group_ids     = [aws_security_group.db.id]
  backup_retention_period    = 3
  availability_zone          = "ap-northeast-2b"
}
