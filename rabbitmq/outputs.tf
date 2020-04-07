output "rabbitmq_elb_dns" {
  description = "ELB DNS Name"
  value       = aws_elb.elb.dns_name
}

output "admin_password" {
  description = "RabbitMq Admin Password"
  value       = random_password.admin_password.result
  sensitive   = true
}

output "rabbit_password" {
  description = "RabbitMQ Password"
  value       = random_password.rabbit_password.result
  sensitive   = true
}

output "secret_cookie" {
  description = "Secret Cookie"
  value       = random_string.secret_cookie.result
  sensitive   = true
}

