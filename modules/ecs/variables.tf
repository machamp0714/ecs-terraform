variable "cluster_name" {
  description = "Name of ECS Cluster"
  type        = string
}

variable "service_name" {
  description = "Name of ECS Service"
  type        = string
}

variable "family_name" {
  description = "Name of Family"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of Public Subnet ids"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of Security Group ids"
  type        = list(string)
}

variable "lb_target_group_arn" {
  description = "ARN of Load Balancer Target Group"
  type        = string
}

variable "enable_public_id" {
  description = "Assign a public IP address to the ENI"
  type        = bool
}

variable "container_definitions_json" {
  description = "JSON of container definition"
  type        = string
}
