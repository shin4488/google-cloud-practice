# IAMモジュールのoutput定義

output "action_service_account_email" {
  description = "GitHub Actions用サービスアカウントのemailアドレス"
  value       = google_service_account.action.email
}
