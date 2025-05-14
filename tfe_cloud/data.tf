data "tfe_oauth_client" "vcs" {
  organization     = var.tfc_organization
  service_provider = var.vcs_oauth_client_name
}
