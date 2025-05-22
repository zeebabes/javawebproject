output "maven_public_ip" {
  value = aws_instance.maven.public_ip
}
 
output "tomcat_public_ip" {
  value = aws_instance.tomcat.public_ip
}