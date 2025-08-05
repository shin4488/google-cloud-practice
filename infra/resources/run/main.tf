resource "google_cloud_run_v2_service" "api_service" {
  annotations      = {}
  client           = "gcloud"
  client_version   = "532.0.0"
  custom_audiences = []
  description      = null
  ingress          = "INGRESS_TRAFFIC_INTERNAL_ONLY"
  labels           = {}
  launch_stage     = "GA"
  location         = var.region
  name             = "api-service"
  project          = var.project_id
  template {
    annotations           = {}
    encryption_key        = null
    execution_environment = "EXECUTION_ENVIRONMENT_GEN2"
    labels = {
      commit-sha = "dummy"
      managed-by = "github-actions"
    }
    max_instance_request_concurrency = 2
    revision                         = null
    service_account                  = var.action_service_account
    session_affinity                 = false
    timeout                          = "300s"
    containers {
      args        = []
      command     = []
      depends_on  = []
      image       = "${var.region}-docker.pkg.dev/${var.project_id}/cloud-run-source-deploy/api-service:latest"
      name        = null
      working_dir = null
      ports {
        container_port = 8080
        name           = "http1"
      }
      resources {
        cpu_idle = true
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
        startup_cpu_boost = false
      }
      startup_probe {
        failure_threshold     = 1
        initial_delay_seconds = 0
        period_seconds        = 240
        timeout_seconds       = 240
        tcp_socket {
          port = 8080
        }
      }
    }
    scaling {
      max_instance_count = 1
      min_instance_count = 0
    }
  }
  traffic {
    percent  = 100
    revision = null
    tag      = null
    type     = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
  }

  lifecycle {
    ignore_changes = [
      template[0].labels.commit-sha,
    ]
  }
}
