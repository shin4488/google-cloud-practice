# 開発ガイド

Google CloudのHTTP関数・ワークフロー・インフラを試すリポジトリ。実装の入口は `src/functions/` の各 `main.py`、処理の連携は `src/workflows/`、SQLは `src/queries/`。

## 開発・検証

- Pythonの依存は各サービスの `requirements.txt` にある。変更したPythonファイルは `python -m py_compile <対象.py>` で構文を確かめられる。自動テストはまだないため、構文の確認を動作の確認とみなさない。
- HTTP関数をローカルで動かすときは、仮想環境に対象サービスの依存をインストールし、そのディレクトリで `functions-framework --target <関数名> --source main.py` を実行する。Dockerfileがあるサービスは、その `CMD` の `--target` と同じ関数を指定する。依存をホスト全体へインストールしない。
- Terraformを変更するときは、[infra/README.md](infra/README.md)、`infra/environments/prod/`、変更するresourceを読む。`terraform fmt -check <対象.tf>` はそのまま実行できる。`terraform validate` は `infra/environments/prod/` で `terraform init -backend=false`（stateを置くバケットに接続しない）の後に実行する。
- Google Cloudに接続する操作（`terraform plan`・`terraform apply`、デプロイ、データの更新）は、ローカルでの確認と分けて扱う。実行前に対象のプロジェクト・認証・権限を確かめ、依頼された範囲だけを行う。認証用のファイルや環境固有の値を、文書・ログ・コミットに書き写さない。
- mainへのpushと、mainを選んだ `deploy-gc-cloudrun.yml` の手動実行（Dockerfileがあるすべてのサービスをデプロイする）で、Google Cloudに反映される。対象のパスとトリガーは `.github/workflows/deploy-gc-cloudrun.yml` と `upload-gcs.yml` にある。公開範囲（Cloud Runのingress、バケットの公開アクセスの防止）は `infra/resources/` のTerraformで設定している。

## 作業の進め方

- 関連箇所・資料・skillsに絞って読み、根拠が足りなければ調査範囲を広げる。
- 判断に必要な不明点は既存資料で確認し、解消できなければ依存する作業の前に質問する。合意済み事項は再確認しない。
- 文書の言語を保ち、日本語は日本人に、英語は英語圏の読者に自然に伝わる表現にする。
- 該当する必須検証を行い、問題を修正する。差分・依存・設定・実行条件が同じなら結果を再利用し、結果と未確認事項を簡潔に報告する。
- 継続する規約と参照先だけを残し、進捗・設定値・他の資料やskillsの手順は複製しない。
- コメントには、コードから読み取れない意図・前提だけを書く。経緯・変わりやすい値・他の資料の場所など、変更のたびに古くなる内容は書かない。
