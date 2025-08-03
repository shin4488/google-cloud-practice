terraform {
  backend "gcs" {
    bucket = "terraform-tfstate-manager"
    prefix = "tfstates"
  }
}
