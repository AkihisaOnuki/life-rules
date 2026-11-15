# Claude プロジェクト再構築キット

新しい Claude アカウント（または新プロジェクト）で「私の人生設計」プロジェクトを同じ状態に戻すための手順。
移行計画: [projects/2026-11-claude-account-migration.md](../projects/2026-11-claude-account-migration.md)

## 1. プロジェクト作成
- 名前: `私の人生設計`
- 公開範囲: private
- リポジトリ: `AkihisaOnuki/life-rules` を追加（プロジェクトに保存）
  - 先に新アカウントで GitHub 連携（https://claude.ai/connect-github）と Claude GitHub App のインストールが必要
- ライブラリ（プロジェクトファイル）: **何も入れなくてよい**。正本はすべてこのリポジトリ。旧プロジェクトのライブラリにある `life-rules/` は初期草案で不要。

## 2. プロジェクト指示（そのまま貼る）

```text
このプロジェクトは、私の生活・活動の方針（ルール）と「何がどこにあるか」の索引を管理する。
正本は GitHub の AkihisaOnuki/life-rules。必ずそのリポジトリの CLAUDE.md に従うこと。

- 「あれどこ？」「次◯◯作るけどどうする？」には、life-rules を根拠に結論ファーストで答える。
- 決まったことは会話中に life-rules の main へ直接コミットしてよい（確認不要）。
- 進行中の作業は life-rules/projects/ の未完了チェックボックスから再開する。
- 秘密情報（パスワード、リカバリーコード、2FAシード、口座番号等）はリポジトリに書かない。
- 日本語、結論ファースト、冗長な説明なし。私はインフラ/セキュリティ（ネスペ・支援士）に強いので基礎説明は不要。
```

## 3. 最初のメッセージ（メモリの種まき。そのまま送る）

```text
life-rules リポジトリの CLAUDE.md、README.md、setup/claude-project-setup.md を読んで、
このプロジェクトの前提をプロジェクトメモリに保存して。
特に「AIへの申し送り」と、projects/ の進行中タスクを把握して、次にやることを教えて。
```

## 4. 個人設定（Preferences）
- 旧アカウントの 設定 → プロフィール の個人設定の文面を、新アカウントにそのまま貼る（このリポジトリには保存しない）。

## 5. 動作確認
- 「メールのルールは？」→ `rules/email.md` を根拠に `<サービス名>@bluemoment.fyi` と答えれば OK。
- 「Cloudflare のログインメールは？」→ `inventory/services.md` を根拠に答えれば OK。

## 旧プロジェクトの構成（参考、2026-11-15 時点）
- スレッド「人生ルール集リポジトリを作る」（完了）: life-rules の初期構成を作成
- スレッド「Proton Mailへメールを移行する」（進行中）: Proton 移行・Tier 0 強化。内容は projects/2026-11-proton-migration.md に集約済み
