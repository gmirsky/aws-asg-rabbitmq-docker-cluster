locals {
  cluster_name = "rabbitmq-${var.name}"
}

locals {
  cluster_tags = merge(var.tags, { 
    "Cluster Name" = local.cluster_name, 
    "Name" = local.cluster_name
     })
}