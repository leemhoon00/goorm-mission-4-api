resource "aws_ecs_task_definition" "server" {
  family                   = var.namespace
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu_unit
  memory                   = var.memory

  container_definitions = jsonencode([
    {
      name      = var.namespace
      image     = "${aws_ecr_repository.ecr.repository_url}:latest"
      cpu       = var.cpu_unit
      memory    = var.memory
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_port
          protocol      = "tcp"
        }
      ]
    }
  ])
}
