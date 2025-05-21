variable "region" {
  default = "us-east-2"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "azs" {
  default = ["us-east-2a", "us-east-2b"]
}

variable "instance_type" {
  default = "t2.medium"
}

variable "key_name" {
  description = "Name of the existing EC2 key pair"
  type        = string
}
