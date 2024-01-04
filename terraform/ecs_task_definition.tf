resource "aws_ecs_task_definition" "server" {
  family                   = var.namespace
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu_unit
  memory                   = var.memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

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
      environment = [
        {
          name  = "DATABASE_URL"
          value = "postgresql://postgres:postgres@${aws_db_instance.db.endpoint}/postgres"
        },
        {
          name  = "WEB_URL"
          value = var.web_url
        }
      ]
    }
  ])
}
