##########################
#   ECR REPOSITORY       #
##########################
resource "aws_ecr_repository" "repo" {
  name         = var.ecr_repo_name
  force_delete = var.repo_protection ? false : true

  image_scanning_configuration { scan_on_push = true }
}

##########################
#   REPOSITORY POLICY    #
##########################
resource "aws_ecr_repository_policy" "policy" {
  repository = aws_ecr_repository.repo.name

  policy = jsonencode({
    Version   = "2008-10-17"
    Statement = local.policy_statements
  })
}
