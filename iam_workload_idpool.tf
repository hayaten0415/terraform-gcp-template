resource "google_iam_workload_identity_pool" "github_actions" {
    provider                                            = google-beta
    workload_identity_pool_id                           = "github-actions"
}

resource "google_iam_workload_identity_pool_provider" "github_actions" {
    provider                                            = google-beta
    workload_identity_pool_id                           = google_iam_workload_identity_pool.github_actions.workload_identity_pool_id
    workload_identity_pool_provider_id                  = "github-actions"
    display_name                                        = "github-actions"
    attribute_mapping                               = {
        "attribute.repository"                          = "assertion.repository"
        "google.subject"                                = "assertion.sub"
    }
    oidc {
        issuer_uri                                      = "https://token.actions.githubusercontent.com"
    }
}

data "google_service_account" "terraform" {
    account_id                                          = var.terraform_service_account_id
}

resource "google_service_account_iam_member" "idpool_repo" {
    service_account_id                                  = data.google_service_account.terraform.name
    role                                                = "roles/iam.workloadIdentityUser"
    member                                              = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github_actions.name}/attribute.repository/${var.github_username}/${var.github_repository}"
}