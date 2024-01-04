resource "aws_security_group" "lb" {
  name        = "loadbalancer"
  description = "Security group for ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ecs" {
  name        = "ecs"
  description = "Security group for ECS task running on Fargate"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Allow ingress traffic from ALB on HTTP only"
    from_port       = 0
    to_port         = 0
    protocol        = -1
    security_groups = [aws_security_group.lb.id]
  }

  egress {
    description = "Allow all egress traffic"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}
