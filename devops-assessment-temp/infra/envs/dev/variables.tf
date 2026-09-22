variable "aws_region" {
  type    = string
  default = "us-east-1"
}
variable "environment" {
  type    = string
  default = "dev"
}
variable "vpc_cidr" {
  type = string
}
variable "public_subnet_cidrs" {
  type = list(string)
}
variable "private_subnet_cidrs" {
  type = list(string)
}
variable "ecs_cpu" {
  type = string
}
variable "ecs_memory" {
  type = string
}
variable "ecs_desired_count" {
  type = number
}
variable "rds_instance_class" {
  type = string
}
variable "rds_allocated_storage" {
  type = number
}
variable "rds_backup_retention" {
  type = number
}
variable "rds_deletion_protection" {
  type = bool
}
variable "rds_multi_az" {
  type = bool
}
