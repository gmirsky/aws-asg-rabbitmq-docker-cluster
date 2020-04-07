resource "aws_elb" "elb" {
  name = "${local.cluster_name}-elb"
  listener {
    instance_port     = 5671
    instance_protocol = "tcp"
    lb_port           = 5671
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 5672
    instance_protocol = "tcp"
    lb_port           = 5672
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 15672
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    interval            = 30
    unhealthy_threshold = 10
    healthy_threshold   = 2
    timeout             = 3
    target              = "TCP:5672"
  }
  subnets         = var.subnet_ids
  idle_timeout    = 3600
  internal        = true
  security_groups = concat([aws_security_group.rabbitmq-elb.id], var.elb_additional_security_group_ids)
  tags            = merge(var.tags, tomap({ Name = "${local.cluster_name}-elb" }))
}
