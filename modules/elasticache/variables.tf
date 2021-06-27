variable "replication_group_id" {
  description = "A replication group name of elasticache"
  type        = string
}

variable "replication_group_description" {
  description = "A replication group description of elasticache"
  type        = string
}

variable "number_cache_clusters" {
  description = "A number of clusters"
  type        = number
}

variable "node_type" {
  description = "A node type of elasticache"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group id"
  type        = list(string)
}

variable "subnet_group_name" {
  description = "A subnet group name"
  type        = string
}

variable "subnet_ids" {
  description = "List subnet id"
  type        = list(string)
}
