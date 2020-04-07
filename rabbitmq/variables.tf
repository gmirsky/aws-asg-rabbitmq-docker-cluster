variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "ssh_key_name" {
  type        = string
  description = "SSH key Name"
}

variable "name" {
  type    = string
  default = "main"
}

variable "min_size" {
  type        = number
  description = "Minimum number of RabbitMQ nodes"
  default     = 2
}

variable "desired_size" {
  type        = number
  description = "Desired number of RabbitMQ nodes"
  default     = 2
}

variable "max_size" {
  type        = number
  description = "Maximum number of RabbitMQ nodes"
  default     = 2
}

variable "subnet_ids" {
  description = "Subnets for RabbitMQ nodes"
  type        = list(string)
}

variable "nodes_additional_security_group_ids" {
  type    = list(string)
  default = []
}

variable "elb_additional_security_group_ids" {
  type    = list(string)
  default = []
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "m5.large"
}

variable "instance_volume_type" {
  description = "EC2 instance volume type: Can be standard, gp2, or io1"
  type        = string
  default     = "standard"
}

variable "instance_volume_size" {
  description = "EC2 Instance volume size in GBs"
  type        = string
  default     = "0"
}

variable "instance_volume_iops" {
  description = "EC2 instance volume IOPS amount"
  type        = string
  default     = "0"
}

variable "tags" {
  description = "Tag variable"
  type        = map
  default     = {}
}

variable "region" {
  type        = string
  description = "Region"
  default     = "us-east-1"
}