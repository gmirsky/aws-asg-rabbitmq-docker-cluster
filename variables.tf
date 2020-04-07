variable "region" {
  type        = string
  description = "Region"
  default     = "us-east-1"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
  default     = "vpc-xxxxxxxx"
}

variable "ingress_cidr_blocks" {
  type = list(string)
  default = [
    "192.168.203.128/26", 
    "192.168.202.128/25", 
    "192.168.203.192/26",  
    "192.168.201.128/25",   
    "192.168.200.128/25", 
  ]
}

variable "ssh_key_name" {
  type        = string
  description = "SSH key Name"
  default     = "Linux_Machine_Key_Pair"
}

variable "name" {
  type        = string
  description = "Name to be used in the cluster"
  default     = "rabbitmq-demo"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets for RabbitMQ nodes"
  default = [
    "subnet-5ebba72a", 
    "subnet-7be8c613", 
    "subnet-9eebc5f6"  
  ]
}

variable "instance_type" {
  type        = string
  description = "EC2 Instance type"
  default     = "t3.small"
}

variable "common_tags" {
  type        = map
  description = "Common tags to be applied to all resources"
  default = {
    Environment       = "Development"
    cost-center       = "000-00-0000"
    terraform-managed = true
  }
}

variable "project_tags" {
  type        = map
  description = "Project specific tags to be applied to all resources."
  default = {
    Project    = "rabbitmq-demo"
    Release    = "0.01"
    Revision   = "0.01"
    Technology = "RabbitMQ"
    Role       = "queue"
  }
}

variable "instance_volume_type" {
  type        = string
  description = "EC2 instance volume type: Can be standard, gp2, or io1"
  default     = "gp2"
  #### NOTE: Validation feature is experimental and will throw a warning on validate, plan or apply.
  # validation {
  #   condition     = contains(["standard", "gp2", "io1"], lower(var.instance_volume_type))
  #   error_message = "The instance_volume_type value must be standard, gp2, or io1."
  # }
}

variable "instance_volume_size" {
  type        = string
  description = "EC2 Instance volume size in GBs"
  default     = "100"
}

variable "instance_volume_iops" {
  type        = string
  description = "EC2 instance volume IOPS amount"
  default     = "300"
}

variable "min_size" {
  type        = number
  description = "Minimum number of RabbitMQ nodes"
  default     = 3
}

variable "desired_size" {
  type        = number
  description = "Desired number of RabbitMQ nodes"
  default     = 3
}

variable "max_size" {
  type        = number
  description = "Maximum number of RabbitMQ nodes"
  default     = 3
}

variable "nodes_additional_security_group_ids" {
  type    = list(string)
  description = "Additional security groups to be applied to the RabbitMQ nodes"
  default = []
}
