#######################
#    TFE VARIABLES    #
#######################
variable "tfc_organization" {
  description = "TFC organization that will own the module"
  type        = string
  default     = "biotornic"
}

variable "vcs_repo_identifier" {
  description = "VCS repo in <org>/<repo> form, e.g. github-org/ecs-service-module"
  type        = string
  default     = "derekmberger/terraform-module-aws-ecr"
}

variable "vcs_oauth_client_name" {
  description = "Exact name of the OAuth client you configured in TFC (e.g. “GitHub”)"
  type        = string
  default     = "github"
}

variable "module_name" {
  description = "Registry-module logical name (letters, numbers, hyphens)"
  type        = string
  default     = "ecr"
}

variable "vcs_branch" {
  description = "Branch that holds the module code (main/master/etc.)"
  type        = string
  default     = "main"
}
