#################
#   PROVIDERS   #
#################
provider "aws" {
  region = var.aws_region
  # default_tags { #Optional ability to implement tags on all applicable resources
  #   tags = {
  #     org           = var.org_name           # e.g. "biotornic"
  #     environment   = var.environment        # e.g. "prod"
  #     region        = var.aws_region         # e.g. "us‑east‑1"
  #     tfc_workspace = var.tfc_workspace_name # your TFC workspace name
  #     vcs_repo      = var.vcs_repo           # your VCS org/name
  #   }
  # }
}

terraform {
  required_providers {
    aws = {
      version = "~> 5.0"
    }
  }
}
