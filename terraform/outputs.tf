output "instance_public_ips" {
  value = [for instance in aws_instance.k8s_nodes : instance.public_ip]
}
