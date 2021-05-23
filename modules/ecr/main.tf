resource "aws_ecr_repository" "ecr" {
  name = var.ecr_name
}

resource "aws_ecr_lifecycle_policy" "ecr_lifecycle" {
  repository = aws_ecr_repository.ecr.name

  policy = <<EDF
    {
      "rules": [
        {
          "rulePriority": 1,
          "description": "Keep last 30 release tagged images",
          "selection": {
            "tagStatus": "tagged",
            "tagPrefixList": ["release"],
            "countType": "imageCountMoreThan",
            "countNumber": 30
          },
          "action": {
            "type": "expire"
          }
        }
      ]
    }
  EDF
}
