module "storage" {
  source = "../../resources/storage"

  project_id = var.project_id
  region     = var.region
  terraform_state_bucket = var.terraform_state_bucket
  sport_bucket = var.sport_bucket
}
