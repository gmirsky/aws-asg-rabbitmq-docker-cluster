resource "aws_security_group" "rabbitmq-cluster-sg" {
  name        = "${var.name}-rabbitmq-cluster-sg"
  vpc_id      = var.vpc_id
  description = "Security Group for instances communicating withrabbitmq cluster"
  ingress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    self        = true
    cidr_blocks = var.ingress_cidr_blocks
  }
  ingress {
    protocol    = "tcp"
    from_port   = 53
    to_port     = 53
    description = "DNS tcp"
    cidr_blocks = var.ingress_cidr_blocks
  }
  ingress {
    protocol    = "udp"
    from_port   = 53
    to_port     = 53
    description = "DNS udp"
    cidr_blocks = var.ingress_cidr_blocks
  }
  ingress {
    protocol    = "tcp"
    from_port   = 4369
    to_port     = 4369
    description = "epmd, a helper discovery daemon used by RabbitMQ nodes and CLI tools"
    cidr_blocks = var.ingress_cidr_blocks
  }
  ingress {
    protocol    = "tcp"
    from_port   = 5671
    to_port     = 5672
    description = "used by AMQP 0-9-1 and 1.0 clients without and with TLS"
    cidr_blocks = var.ingress_cidr_blocks
  }
  ingress {
    protocol    = "tcp"
    from_port   = 5984
    to_port     = 5984
    description = "Erlang http API ports"
    cidr_blocks = var.ingress_cidr_blocks
  }
  ingress {
    protocol    = "tcp"
    from_port   = 25672
    to_port     = 25672
    description = "used for inter-node and CLI tools communication (Erlang distribution server port)"
    cidr_blocks = var.ingress_cidr_blocks
  }
  ingress {
    protocol    = "tcp"
    from_port   = 35672
    to_port     = 35682
    description = "used by CLI tools (Erlang distribution client ports) for communication with nodes"
    cidr_blocks = var.ingress_cidr_blocks
  }
  ingress {
    protocol    = "tcp"
    from_port   = 15672
    to_port     = 15672
    description = "HTTP API clients, management UI and rabbitmqadmin (only if the management plugin is enabled)"
    cidr_blocks = var.ingress_cidr_blocks
  }
  # ingress {
  #   protocol    = "tcp"
  #   from_port   = 15692
  #   to_port     = 15692
  #   description = "Prometheus metrics (only if the Prometheus plugin is enabled)"
  #   cidr_blocks = var.ingress_cidr_blocks
  # }
  egress {
    protocol  = "-1"
    from_port = 0
    to_port   = 0
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
  tags = merge(var.common_tags, var.project_tags, tomap({ Name = "${var.name}-rabbitmq-cluster-sg" }))
}

resource "aws_security_group" "rabbitmq-cluster-ssh-sg" {
  name        = "${var.name}-rabbitmq-cluster-ssh-sg"
  vpc_id      = var.vpc_id
  description = "Security Group for instances communicating withrabbitmq cluster"
  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    description = "ssh port to RabbitMQ nodes"
    cidr_blocks = var.ingress_cidr_blocks
  }
  egress {
    protocol  = "-1"
    from_port = 0
    to_port   = 0
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
  tags = merge(var.common_tags, var.project_tags, tomap({ Name = "${var.name}-rabbitmq-cluster-ssh-sg" }))
}

resource "aws_security_group" "rabbitmq-cluster-stomp-sg" {
  name        = "${var.name}-rabbitmq-cluster-stomp-sg"
  vpc_id      = var.vpc_id
  description = "Security Group for instances communicating withrabbitmq cluster"
  ingress {
    protocol    = "tcp"
    from_port   = 61613
    to_port     = 61614
    description = "STOMP clients without and with TLS (only if the STOMP plugin is enabled)"
    cidr_blocks = var.ingress_cidr_blocks
  }
  ingress {
    protocol    = "tcp"
    from_port   = 15674
    to_port     = 15674
    description = "STOMP-over-WebSockets clients (only if the Web STOMP plugin is enabled)"
    cidr_blocks = var.ingress_cidr_blocks
  }
  egress {
    protocol  = "-1"
    from_port = 0
    to_port   = 0
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
  tags = merge(var.common_tags, var.project_tags, tomap({ Name = "${var.name}-rabbitmq-cluster-stomp-sg" }))
}

resource "aws_security_group" "rabbitmq-cluster-mqtt-sg" {
  name        = "${var.name}-rabbitmq-cluster-mqtt-sg"
  vpc_id      = var.vpc_id
  description = "Security Group for instances communicating withrabbitmq cluster"
  ingress {
    protocol    = "tcp"
    from_port   = 1883
    to_port     = 1883
    description = "MQTT clients without and with TLS, if the MQTT plugin is enabled)"
    cidr_blocks = var.ingress_cidr_blocks
  }
  ingress {
    protocol    = "tcp"
    from_port   = 8883
    to_port     = 8883
    description = "MQTT clients without and with TLS, if the MQTT plugin is enabled)"
    cidr_blocks = var.ingress_cidr_blocks
  }
  ingress {
    protocol    = "tcp"
    from_port   = 15675
    to_port     = 15675
    description = "MQTT-over-WebSockets clients (only if the Web MQTT plugin is enabled)"
    cidr_blocks = var.ingress_cidr_blocks
  }
  egress {
    protocol  = "-1"
    from_port = 0
    to_port   = 0
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
  tags = merge(var.common_tags, var.project_tags, tomap({ Name = "${var.name}-rabbitmq-cluster-mqtt-sg" }))
}

resource "aws_security_group" "rabbitmq-elb-sg" {
  name        = "${var.name}-rabbitmq-elb-sg"
  vpc_id      = var.vpc_id
  description = "Security Group for instances communicating withrabbitmq cluster"
  ingress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    self        = true
    cidr_blocks = var.ingress_cidr_blocks
  }
  ingress {
    protocol    = "tcp"
    from_port   = 53
    to_port     = 53
    description = "DNS tcp"
    cidr_blocks = var.ingress_cidr_blocks
  }
  ingress {
    protocol    = "udp"
    from_port   = 53
    to_port     = 53
    description = "DNS udp"
    cidr_blocks = var.ingress_cidr_blocks
  }
  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    description = "http"
    cidr_blocks = var.ingress_cidr_blocks
  }
  ingress {
    protocol    = "tcp"
    from_port   = 5671
    to_port     = 5672
    description = "used by AMQP 0-9-1 and 1.0 clients without and with TLS"
    cidr_blocks = var.ingress_cidr_blocks
  }
  ingress {
    protocol    = "tcp"
    from_port   = 15672
    to_port     = 15672
    description = "HTTP API clients, management UI and rabbitmqadmin (only if the management plugin is enabled)"
    cidr_blocks = var.ingress_cidr_blocks
  }
  egress {
    protocol  = "-1"
    from_port = 0
    to_port   = 0
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
  tags = merge(var.common_tags, var.project_tags, tomap({ Name = "${var.name}-rabbitmq-elb-sg" }))
}
