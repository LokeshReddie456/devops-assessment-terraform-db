variable "environment" {
  type        = string
  description = "Deployment environment name"
}
variable "vpc_cidr" {
  type        = string
  description = "Base CIDR block for the VPC"
  default     = "10.0.0.0/16"
}
variable "availability_zones" {
  type        = list(string)
  description = "Availability zones list"
  default     = ["us-east-1a", "us-east-1b"]
}
variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for public subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for private subnets"
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}
