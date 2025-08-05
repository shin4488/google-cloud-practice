# Google Cloud Storageの定義

resource "google_storage_bucket" "terraform_tfstate_manager" {
  default_event_based_hold    = false
  enable_object_retention     = false
  force_destroy               = false
  labels                      = {}
  location                    = var.region
  name                        = var.terraform_state_bucket
  project                     = var.project_id
  public_access_prevention    = "enforced"
  requester_pays              = false
  rpo                         = null
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
  lifecycle_rule {
    action {
      storage_class = null
      type          = "Delete"
    }
    condition {
      age                                     = 0
      created_before                          = null
      custom_time_before                      = null
      days_since_custom_time                  = 0
      days_since_noncurrent_time              = 0
      matches_prefix                          = []
      matches_storage_class                   = []
      matches_suffix                          = []
      noncurrent_time_before                  = null
      num_newer_versions                      = 3
      send_age_if_zero                        = true
      send_days_since_custom_time_if_zero     = false
      send_days_since_noncurrent_time_if_zero = false
      send_num_newer_versions_if_zero         = false
      with_state                              = "ARCHIVED"
    }
  }
  lifecycle_rule {
    action {
      storage_class = null
      type          = "Delete"
    }
    condition {
      age                                     = 0
      created_before                          = null
      custom_time_before                      = null
      days_since_custom_time                  = 0
      days_since_noncurrent_time              = 7
      matches_prefix                          = []
      matches_storage_class                   = []
      matches_suffix                          = []
      noncurrent_time_before                  = null
      num_newer_versions                      = 0
      send_age_if_zero                        = true
      send_days_since_custom_time_if_zero     = false
      send_days_since_noncurrent_time_if_zero = false
      send_num_newer_versions_if_zero         = false
      with_state                              = "ANY"
    }
  }
  soft_delete_policy {
    retention_duration_seconds = 604800
  }
  versioning {
    enabled = true
  }
}

resource "google_storage_bucket" "workflows_sports" {
  default_event_based_hold    = false
  enable_object_retention     = false
  force_destroy               = false
  labels                      = {}
  location                    = var.region
  name                        = var.sport_bucket
  project                     = var.project_id
  public_access_prevention    = "enforced"
  requester_pays              = false
  rpo                         = null
  storage_class               = "STANDARD"
  uniform_bucket_level_access = true
  soft_delete_policy {
    retention_duration_seconds = 604800
  }
}
