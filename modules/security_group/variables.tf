variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
}

variable "name" {
  description = "Name of security group"
  type        = string
}

variable "port" {
  description = "Port number to allow communication"
  type        = number
}

variable "cidr_blocks" {
  description = "List of IPv4 CIDR ranges to use on all ingress rules"
  type        = list(string)
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}
