variable "environment" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "public_subnet_ids" {
  type = list(string)
}
variable "private_subnet_ids" {
  type = list(string)
}
variable "container_image" {
  type    = string
  default = "public.ecr.aws/nginx/nginx:alpine"
}
variable "container_port" {
  type    = number
  default = 80
}
variable "cpu" {
  type = string
}
variable "memory" {
  type = string
}
variable "desired_count" {
  type = number
}
