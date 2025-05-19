variable "aws_region" {
  default = "us-east-2"
}
 
variable "ami_id" {
  description = "Amazon Linux 2 AMI"
  default     = "ami-060988b0dff2faa7c"
}
 
variable "key_name" {
  description = "SSH key name"
  type        = string
}