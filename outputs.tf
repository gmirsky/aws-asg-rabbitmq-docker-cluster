output "rabbitmq_elb_dns" {
  description = "ELB DNS Name"
  value       = module.rabbitmq.rabbitmq_elb_dns
}

output "admin_password" {
  description = "RabbitMq Admin Password"
  value       = module.rabbitmq.admin_password
  sensitive   = true
}

output "rabbit_password" {
  description = "RabbitMQ Password"
  value       = module.rabbitmq.rabbit_password
  sensitive   = true
}

output "secret_cookie" {
  description = "Secret Cookie"
  value       = module.rabbitmq.secret_cookie
  sensitive   = true
}
