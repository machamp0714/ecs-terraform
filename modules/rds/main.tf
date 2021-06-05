locals {
  parameter_group_description = coalesce(var.parameter_group_description, format("%s parameter group", var.parameter_group_name))
  option_group_description    = coalesce(var.option_group_description, format("%s option group", var.option_group_name))
}

resource "aws_db_parameter_group" "this" {
  name        = var.parameter_group_name
  family      = "mysql8.0"
  description = local.parameter_group_description

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name  = parameter.value.name
      value = parameter.value.value
    }
  }
}

resource "aws_db_option_group" "this" {
  name                     = var.option_group_name
  option_group_description = local.option_group_description
  engine_name              = "mysql"
  major_engine_version     = "8.0"

  dynamic "option" {
    for_each = var.options
    content {
      option_name = option.value.option_name
    }
  }
}

resource "aws_db_subnet_group" "this" {
  name       = var.subnet_group_name
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "this" {
  engine                     = "mysql"
  engine_version             = "8.0.20"
  port                       = 3306
  identifier                 = var.identifier
  instance_class             = var.instance_class
  storage_type               = var.storage_type
  allocated_storage          = var.allocated_storage
  username                   = var.username
  password                   = var.password
  multi_az                   = var.multi_az
  backup_window              = var.backup_window
  backup_retention_period    = var.backup_retention_period
  maintenance_window         = var.maintenance_window
  publicly_accessible        = false
  auto_minor_version_upgrade = false
  deletion_protection        = false
  skip_final_snapshot        = false
  apply_immediately          = false
  vpc_security_group_ids     = var.vpc_security_group_ids
  parameter_group_name       = aws_db_parameter_group.this.name
  option_group_name          = aws_db_option_group.this.name
  db_subnet_group_name       = aws_db_subnet_group.this.name

  lifecycle {
    ignore_changes = [password]
  }
}
