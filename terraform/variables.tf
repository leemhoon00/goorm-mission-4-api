variable "availability_zones" {
  type = list(string)
}

variable "image_id" {
  type    = string
  default = "ami-01123b84e2a4fba05"
}

variable "key_name" {
  type = string
}
