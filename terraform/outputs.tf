##########################
#        OUTPUTS         #
##########################
output "repository_arn" {
  description = "ARN of the ECR repository"
  value       = aws_ecr_repository.repo.arn
}

output "repository_url" {
  description = "Full ECR repository URL (registry/namespace/repo)"
  value       = aws_ecr_repository.repo.repository_url
}

# Consolidated object
output "repository_info" {
  description = "Object containing ARN and URL of the repository"
  value = {
    arn = aws_ecr_repository.repo.arn
    url = aws_ecr_repository.repo.repository_url
  }
}

# JSON of the applied repository policy (kept for audit/debug)
output "policy_json" {
  value       = aws_ecr_repository_policy.policy.policy
  description = "Final JSON policy applied to the repository"
}
