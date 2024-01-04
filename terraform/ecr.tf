resource "aws_ecr_repository" "ecr" {
  name         = var.namespace
  force_delete = true
}

output "ecr_repository_url" {
  value = aws_ecr_repository.ecr.repository_url
}
