# 開発ガイド

Google CloudのHTTP関数・ワークフロー・インフラを試すリポジトリ。実装の入口は `src/functions/` の各 `main.py`、処理の連携は `src/workflows/`、SQLは `src/queries/`。READMEの古い `services/` 構成ではなく現在のソース配置を確認する。

## 読む条件と検証

- Pythonの依存は各サービスの `requirements.txt`。変更したPythonファイルは `python -m py_compile <対象.py>` で構文確認できる。自動テストの実行定義は未整備なので、構文確認を動作テストと扱わない。
- HTTP関数のローカル確認は、分離したPython環境で対象サービスの依存を用意し、そのディレクトリで `functions-framework --target main --source main.py` を入口にする。依存をホスト全体へインストールしない。
- Terraform変更時は [infra/README](infra/README.md)と `infra/environments/prod/`・変更するresourceを確認する。`terraform fmt -check <対象.tf>` はローカル確認、validateは初期化済みの対象moduleで行う。
- Cloudへの通信・リソース変更はローカル構文確認と区別する。対象プロジェクト・認証・実行権限を確認し、デプロイ・適用・データ更新は依頼された範囲で行う。認証用ファイルや環境固有値を文書・ログ・コミットへ転記しない。
- mainへのpushでCloudへの反映が起きる。対象パス、トリガー、公開範囲は `.github/workflows/deploy-gc-cloudrun.yml` と `upload-gcs.yml` を確認し、READMEの旧手順だけで実行しない。

## 調査と指示の保守

- `AGENTS.md` は `CLAUDE.md` への相対リンク。本文は一度読み、実体を編集する。
- `rg` は対象ディレクトリから名前・見出し・シンボルを探す。通常は `-g` で依存・成果物・ログ・ロックファイル・生成コードを除外し、依存・生成・型・障害の調査では直接読む。見つからなければ範囲・除外を見直す。
- 必須検証を行い、要点・失敗箇所を報告する。同じ差分・依存・設定・実行条件の結果は再利用する。
- ここは恒久規約・必須条件・主要コマンド・参照先に限る。進捗はチャット・既存Issue/PR、機能・構成・依存・設定等の現在値は元の定義へ。規約・条件・参照先の変更や継続して必要な判断基準の追加時に更新する。
- スキルは説明から選び、該当 `SKILL.md` に従う。一覧・手順は転記せず、このガイドの必須適用条件は守る。
