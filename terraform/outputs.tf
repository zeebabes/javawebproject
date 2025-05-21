output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = [for subnet in aws_subnet.public : subnet.id]
}

output "instance_public_ips" {
  description = "Public IP addresses of all Kubernetes nodes"
  value       = [for instance in aws_instance.k8s_nodes : instance.public_ip]
}
