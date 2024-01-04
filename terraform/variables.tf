variable "image_id" {
  type    = string
  default = "ami-01123b84e2a4fba05"
}

variable "key_name" {
  type = string
}

variable "certificate_arn" {
  type = string
}

variable "zone_id" {
  type = string
}

variable "namespace" {
  type    = string
  default = "goorm-mission-4"
}

variable "cpu_unit" {
  description = "Amount of CPU units for a single ECS task"
  default     = 256
  type        = number
}

variable "memory" {
  description = "Amount of memory in MB for a single ECS task"
  default     = 1024
  type        = number
}

variable "container_port" {
  description = "Port of the container"
  type        = number
  default     = 3000
}

variable "ecs_task_desired_count" {
  description = "The number of instances of the task definition to place and keep running"
  type        = number
  default     = 0
}
