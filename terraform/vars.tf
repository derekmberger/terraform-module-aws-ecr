##########################
#        VARIABLES       #
##########################
variable "ecr_repo_name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "allowed_account_roots" {
  description = "Optional list of account-root ARNs allowed to pull"
  type        = list(string)
  default     = []
}

variable "principal_org_id" {
  description = "Optional AWS Organizations ID whose member accounts may pull"
  type        = string
  default     = ""
}

variable "repo_protection" {
  description = "If true, disables automatic repository deletion (sets force_delete = false)"
  type        = bool
  default     = false
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}
