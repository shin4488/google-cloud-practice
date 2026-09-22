# 開発ガイド

Google CloudのHTTP関数・ワークフロー・インフラを試すリポジトリ。実装の入口は `src/functions/` の各 `main.py`、処理の連携は `src/workflows/`、SQLは `src/queries/`。READMEの古い `services/` 構成ではなく現在のソース配置を確認する。

## 読む条件と検証

- Pythonの依存は各サービスの `requirements.txt`。変更したPythonファイルは `python -m py_compile <対象.py>` で構文確認できる。自動テストの実行定義は未整備なので、構文確認を動作テストと扱わない。
- HTTP関数のローカル確認は、分離したPython環境で対象サービスの依存を用意し、そのディレクトリで `functions-framework --target main --source main.py` を入口にする。依存をホスト全体へインストールしない。
- Terraform変更時は [infra/README](infra/README.md)と `infra/environments/prod/`・変更するresourceを確認する。`terraform fmt -check <対象.tf>` はローカル確認、validateは初期化済みの対象moduleで行う。
- Cloudへの通信・リソース変更はローカル構文確認と区別する。対象プロジェクト・認証・実行権限を確認し、デプロイ・適用・データ更新は依頼された範囲で行う。認証用ファイルや環境固有値を文書・ログ・コミットへ転記しない。
- mainへのpushでCloudへの反映が起きる。対象パス、トリガー、公開範囲は `.github/workflows/deploy-gc-cloudrun.yml` と `upload-gcs.yml` を確認し、READMEの旧手順だけで実行しない。

## 作業の進め方

- 関連箇所・資料・skillsに絞って読み、根拠が足りなければ調査範囲を広げる。
- 判断に必要な不明点は既存資料で確認し、解消できなければ依存する作業の前に質問する。合意済み事項は再確認しない。
- 文書の言語を保ち、日本語は日本人に、英語は英語圏の読者に自然に伝わる表現にする。
- 該当する必須検証を行い、問題を修正する。差分・依存・設定・実行条件が同じなら結果を再利用し、結果と未確認事項を簡潔に報告する。
- 継続する規約と参照先だけを残し、進捗・設定値・他の資料やskillsの手順は複製しない。
