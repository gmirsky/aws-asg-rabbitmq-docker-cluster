module "rabbitmq" {
  source       = "./rabbitmq"
  vpc_id       = var.vpc_id
  ssh_key_name = var.ssh_key_name
  subnet_ids   = var.subnet_ids
  nodes_additional_security_group_ids = [
    aws_security_group.rabbitmq-cluster-sg.id,
    aws_security_group.rabbitmq-cluster-ssh-sg.id,
    aws_security_group.rabbitmq-cluster-stomp-sg.id,
    aws_security_group.rabbitmq-cluster-mqtt-sg.id,
  ]
  min_size                          = var.min_size
  max_size                          = var.max_size
  desired_size                      = var.desired_size
  instance_type                     = var.instance_type
  name                              = var.name
  tags                              = merge(var.common_tags, var.project_tags)
  region                            = var.region
  elb_additional_security_group_ids = [aws_security_group.rabbitmq-elb-sg.id]
}
