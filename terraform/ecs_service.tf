resource "aws_ecs_service" "service" {
  name            = var.namespace
  cluster         = aws_ecs_cluster.server.id
  task_definition = aws_ecs_task_definition.server.arn
  desired_count   = var.ecs_task_desired_count
  launch_type     = "FARGATE"

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs.arn
    container_name   = var.namespace
    container_port   = var.container_port
  }

  network_configuration {
    security_groups  = [aws_security_group.ecs.id]
    subnets          = [aws_subnet.server_a.id, aws_subnet.server_b.id]
    assign_public_ip = false
  }
}
