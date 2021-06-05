variable "parameter_group_name" {
  description = "The name of the DB parameter group"
  type        = string
}

variable "parameter_group_description" {
  description = "The description of DB parameter group"
  type        = string
  default     = ""
}

variable "parameters" {
  description = "A list of DB parameter maps"
  type        = list(map(string))
  default     = []
}

variable "option_group_name" {
  description = "The name of DB option group name"
  type        = string
}

variable "option_group_description" {
  description = "The description of DB option group"
  type        = string
  default     = ""
}

variable "options" {
  description = "A list of DB option maps"
  type        = list(map(string))
  default     = []
}

variable "subnet_group_name" {
  description = "The name of DB subnet group"
  type        = string
}

variable "subnet_ids" {
  description = "A list of VPC subnet ids"
  type        = list(string)
}

variable "identifier" {
  description = "The name of RDS instance"
  type        = string
}

variable "instance_class" {
  description = "The instance type of RDS"
  type        = string
}

variable "storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD)"
  type        = string
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
}

variable "username" {
  description = "Username for the master DB user"
  type        = string
}

variable "password" {
  description = "Password for the master DB user"
  type        = string
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = false
}

variable "backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  type        = string
  default     = null
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = null
}

variable "maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  type        = string
  default     = null
}

variable "vpc_security_group_ids" {
  description = "A List of VPC security group id"
  type        = list(string)
}
