##########################
#         LOCALS         #
##########################
locals {
  account_root_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"

  # Base statement: always the repo’s own account
  stmt_local_account = [
    {
      Sid       = "AllowLocalAccountPull"
      Effect    = "Allow"
      Principal = { AWS = local.account_root_arn }
      Action = [
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage"
      ]
    }
  ]

  # Optional statement: explicit account allow-list
  stmt_account_list = length(var.allowed_account_roots) > 0 ? [
    {
      Sid       = "AllowSpecificAccounts"
      Effect    = "Allow"
      Principal = { AWS = var.allowed_account_roots }
      Action = [
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage"
      ]
    }
  ] : []

  # Optional statement: all accounts in the given org
  stmt_org = var.principal_org_id != "" ? [
    {
      Sid       = "AllowOrgAccounts"
      Effect    = "Allow"
      Principal = { AWS = "*" }
      Action = [
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage"
      ]
      Condition = {
        StringEquals = {
          "aws:PrincipalOrgID" = var.principal_org_id
        }
      }
    }
  ] : []

  # Combine them (order doesn’t matter here)
  policy_statements = concat(
    local.stmt_local_account,
    local.stmt_account_list,
    local.stmt_org
  )
}
