resource "aws_security_group" "this" {
  name   = var.name
  vpc_id = var.vpc_id
  tags = merge(
    map("Name", "${var.tags["system"]}-${var.tags["env"]}-${var.name}")
  )
}

resource "aws_security_group_rule" "ingress_with_cidr_blocks" {
  count = length(var.ingress_with_cidr_blocks)

  type              = "ingress"
  from_port         = var.ingress_with_cidr_blocks[count.index].from_port
  to_port           = var.ingress_with_cidr_blocks[count.index].to_port
  protocol          = var.ingress_with_cidr_blocks[count.index].protocol
  cidr_blocks       = var.ingress_with_cidr_blocks[count.index].cidr_blocks
  security_group_id = aws_security_group.this.id
}

resource "aws_security_group_rule" "ingress_with_source_security_group_id" {
  count = length(var.ingress_with_source_security_group_id)

  type                     = "ingress"
  from_port                = var.ingress_with_source_security_group_id[count.index].from_port
  to_port                  = var.ingress_with_source_security_group_id[count.index].to_port
  protocol                 = var.ingress_with_source_security_group_id[count.index].protocol
  source_security_group_id = var.ingress_with_source_security_group_id[count.index].source_security_group_id
  security_group_id        = aws_security_group.this.id
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
}
