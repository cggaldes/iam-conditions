variable org_id {
    type = string
    description = "identifier of the gcp org to create"
}

variable project_id {
    type = string
    description = "identifier of the project to create"
}

variable user_email {
    type = string
    description = "email address of the user that will impersonate the service account"
}

# create GCP Project
# resource "google_project" "iam_conditions_project" {
#   name       = "PoC GCP Project to showcase IAM Conditions"
#   project_id = var.project_id
#   org_id     = var.org_id
# }

# create GCP Service Account
resource "google_service_account" "compute_creator_sa" {
  account_id   = "compute-creator-sa"
  display_name = "Compute Creator SA"
  project      = var.project_id
}

# assign compute admin to service account
resource "google_project_iam_member" "compute_creator_iam_roles" {
  for_each = toset( ["roles/serviceusage.serviceUsageConsumer", "roles/compute.admin"] )

  project = var.project_id
  role    = each.key
  member  = format("%s%s", "serviceAccount:",google_service_account.compute_creator_sa.email)
}

# assign necessary roles to impersonate service account
resource "google_project_iam_member" "impersonation_roles" {
    
  for_each = toset( ["roles/iam.serviceAccountUser", "roles/iam.serviceAccountTokenCreator"] )

  project = var.project_id
  role    = each.key
  member  = format("%s%s", "user:",var.user_email)
}

resource "google_project_iam_member" "storage_roles" {
  project = var.project_id
  role    = "roles/storage.admin"
  member  = format("%s%s", "user:",var.user_email)

  condition {
    title       = "expires_after_2022_01_31_1330"
    description = "Expiring at 13:30 of 2022-01-31"
    expression  = "request.time < timestamp(\"2022-01-31T03:00:00Z\")"
  }
}

output "compute_creator_sa_email" {
    value = google_service_account.compute_creator_sa.email    
}