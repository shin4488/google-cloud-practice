```
terraform init
```

importブロックのtoはルート配下（モジュールを指定しない）を指定する
```
terraform plan -generate-config-out="generated.tf"
```
generated.tfが生成される条件（以下でないこと）
- インポート対象リソースに対応する resource ブロックがすでに存在している
生成対象となる “まだ定義されていない” リソースがないため、何も書き出されずファイルも作られません 
- 指定した出力ファイルパスが既存ファイルと重複している
ドキュメントにもあるとおり、既存ファイルを指定するとエラーとなり何も書き込まれません 
- Terraform バージョンが v1.5 未満
-generate-config-out は Terraform v1.5 からの実験的機能です。バージョンをご確認ください。

importのtoをモジュール参照にしているとリソース定義が必要になるので、モジュール参照ではなくルート参照にする
```terraform
# NG
import {
  to = module.resources.google_storage_bucket.workflows_sports       # 任意：Terraform 内でのローカル識別子
  id = "workflows-sports"                           # 必須：GCS 上のバケット名と完全一致
}
```
```terraform
# OK
import {
  to = google_storage_bucket.workflows_sports       # 任意：Terraform 内でのローカル識別子
  id = "workflows-sports"                           # 必須：GCS 上のバケット名と完全一致
}
```

generated.tfに出力された内容をもとにresourceブロックを記述する
generated.tfの内容は削除する
