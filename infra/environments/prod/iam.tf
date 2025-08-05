module "iam" {
  source = "../../resources/iam"

  project_id = var.project_id
  owner_email = var.owner_email
  owner_roles = var.owner_roles
}
