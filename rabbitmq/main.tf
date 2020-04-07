
resource "aws_security_group" "rabbitmq-elb" {
  name        = "${var.name}-rabbitmq-elb"
  vpc_id      = var.vpc_id
  description = "Security Group for the rabbitmq elb"
  ingress {
    protocol  = -1
    from_port = 0
    to_port   = 0
    self      = true
  }
  ingress {
    protocol    = "tcp"
    from_port   = 5672
    to_port     = 5672
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol    = "tcp"
    from_port   = 15672
    to_port     = 15672
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(var.tags,
    tomap({ Name = "${var.name}-rabbitmq-elb" })
  )
}

resource "aws_security_group" "rabbitmq-nodes" {
  name        = "${local.cluster_name}-nodes"
  vpc_id      = var.vpc_id
  description = "Security Group for the rabbitmq nodes"
  ingress {
    protocol  = -1
    from_port = 0
    to_port   = 0
    self      = true
  }
  ingress {
    protocol        = "tcp"
    from_port       = 5672
    to_port         = 5672
    security_groups = [aws_security_group.rabbitmq-elb.id]
  }
  ingress {
    protocol        = "tcp"
    from_port       = 15672
    to_port         = 15672
    security_groups = [aws_security_group.rabbitmq-elb.id]
  }
  egress {
    protocol  = "-1"
    from_port = 0
    to_port   = 0
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
  tags = merge(var.tags, tomap({ Name = "${local.cluster_name}-nodes" }))
}

resource "aws_launch_configuration" "rabbitmq" {
  name_prefix   = "${local.cluster_name}-"
  image_id      = data.aws_ami_ids.ami.ids[0]
  instance_type = var.instance_type
  key_name      = var.ssh_key_name
  security_groups = concat(
    [aws_security_group.rabbitmq-nodes.id],
    var.nodes_additional_security_group_ids
  )
  iam_instance_profile = aws_iam_instance_profile.profile.id
  user_data            = data.template_file.cloud-init.rendered
  root_block_device {
    volume_type           = var.instance_volume_type
    volume_size           = var.instance_volume_size
    iops                  = var.instance_volume_iops
    delete_on_termination = true
  }
  lifecycle {
    create_before_destroy = true
  }
  enable_monitoring = true
}

resource "aws_autoscaling_group" "rabbitmq" {
  name                      = local.cluster_name
  min_size                  = var.min_size
  desired_capacity          = var.desired_size
  max_size                  = var.max_size
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  launch_configuration      = aws_launch_configuration.rabbitmq.name
  load_balancers            = [aws_elb.elb.name]
  vpc_zone_identifier       = var.subnet_ids
  tags                      = data.null_data_source.asg-tags.*.outputs
}
