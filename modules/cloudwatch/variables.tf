variable "name" {
  description = "A name for the log group"
  type        = string
  default     = null
}

variable "retention_in_days" {
  description = "Sepecifies the number of days you want to retain log events in the specified log group"
  type        = number
  default     = null
}
