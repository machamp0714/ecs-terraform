resource "aws_elasticache_replication_group" "this" {
  replication_group_id          = var.replication_group_id
  replication_group_description = var.replication_group_description
  node_type                     = var.node_type
  security_group_ids            = var.security_group_ids
  number_cache_clusters         = var.number_cache_clusters
  subnet_group_name             = aws_elasticache_subnet_group.this.name
  engine                        = "redis"
  engine_version                = "5.0.6"
  port                          = 6379
}

resource "aws_elasticache_subnet_group" "this" {
  name       = var.subnet_group_name
  subnet_ids = var.subnet_ids
}
