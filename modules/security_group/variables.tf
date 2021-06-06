variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
}

variable "name" {
  description = "Name of security group"
  type        = string
}

variable "ingress_with_cidr_blocks" {
  description = "A list of ingress rule with cidr blocks"
  default     = []
}

variable "ingress_with_source_security_group_id" {
  description = "A list of ingress rule with source security group id"
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}
