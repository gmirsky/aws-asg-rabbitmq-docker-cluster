data "aws_vpc" "vpc" {
  id = var.vpc_id
}

data "aws_region" "current" {
}

data "aws_ami_ids" "ami" {
  owners = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn-ami-hvm-2018*-gp2"]
  }
}

data "aws_iam_policy_document" "policy_doc" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "template_file" "cloud-init" {
  template = file("${path.module}/cloud-init.yaml")
  vars = {
    sync_node_count  = 3
    asg_name         = local.cluster_name
    region           = data.aws_region.current.name
    admin_password   = random_password.admin_password.result
    rabbit_password  = random_password.rabbit_password.result
    secret_cookie    = random_string.secret_cookie.result
    message_timeout  = (3 * 24 * 60 * 60 * 1000) # 3 days
  }
}

data "null_data_source" "asg-tags" {
  count = "${length(keys(local.cluster_tags))}"
  inputs = {
    key                 = "${element(keys(local.cluster_tags), count.index)}"
    value               = "${element(values(local.cluster_tags), count.index)}"
    propagate_at_launch = "true"
  }
}

