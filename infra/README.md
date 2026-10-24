# Terraform

`infra/environments/prod/` がルートモジュールで、`infra/resources/` 以下のモジュールを呼び出します。コマンドは `infra/environments/prod/` で実行します。

## 既存リソースのインポート

1. `terraform init` を実行します。
2. `import` ブロックの `to` に、モジュールを含まないアドレスを書きます（下の例の「手順 2」）。モジュール内のアドレスを書くと、そのモジュールに resource ブロックが必要になるためです。
3. `terraform plan -generate-config-out="generated.tf"` を実行し、resource ブロックを generated.tf に出力します。
4. generated.tf の内容をもとに、`infra/resources/` のモジュールに resource ブロックを書きます。
5. `import` ブロックの `to` を、resource ブロックを書いたモジュールのアドレス（下の例の「手順 5」）に書き換え、generated.tf を削除します。

```terraform
# 手順 2: 設定を生成するときのアドレス
import {
  to = google_storage_bucket.workflows_sports
  id = "workflows-sports"
}

# 手順 5: モジュールに resource ブロックを書いた後のアドレス
import {
  to = module.storage.google_storage_bucket.workflows_sports
  id = "workflows-sports"
}
```

次の場合、generated.tf は作られません。

| 条件 | 理由 |
| --- | --- |
| インポート対象の resource ブロックがすでにある | 生成する設定がない |
| 出力先に既存のファイルを指定した | Terraform がエラーにする |
| Terraform が v1.5 未満 | `-generate-config-out` は v1.5 で実験的機能として追加された |
