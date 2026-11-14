# life-rules

私（akihisa）の生活・活動の **方針（ルール）** と **「何がどこにあるか」の索引** を一元管理するリポジトリ。

- ルール = 「次に◯◯を作る/登録するとき、どうするか」
- 索引 = 「◯◯はどこにあるか」
- 決定記録 = 「なぜそう決めたか」

> ⚠️ パスワード・リカバリーコード・2FAシード・口座番号などの **秘密情報は書かない**。「どのパスワードマネージャのどのVaultにあるか」だけを書く。

## クイック索引（よく聞くもの）

| 知りたいこと | 見る場所 |
|---|---|
| 新しいサービスに登録するとき、どのメールアドレスを使う？ | [rules/email.md](rules/email.md) |
| どのアカウントで何を管理している？ | [rules/accounts.md](rules/accounts.md) |
| ファイル・写真・メモはどこに置く？ | [rules/storage.md](rules/storage.md) |
| 契約中サービスの一覧（どのアカウント/メールで登録したか） | [inventory/services.md](inventory/services.md) |
| 発行済みメールエイリアスの台帳 | [inventory/email-aliases.md](inventory/email-aliases.md) |
| 全体の原則・命名規則 | [rules/00-principles.md](rules/00-principles.md) |
| 過去の決定とその理由 | [decisions/](decisions/) |
| 進行中の移行・プロジェクト | [projects/](projects/)（例: [Proton移行](projects/2026-11-proton-migration.md)） |

## ディレクトリ構成

```
life-rules/
├── README.md              # この索引
├── CLAUDE.md              # AIへの回答ルール（「どこ？」と聞かれたときの答え方）
├── rules/                 # 方針・ルール（To-Be）
│   ├── 00-principles.md   # 全体原則・命名規則
│   ├── email.md           # メール運用（Proton Mail + 独自ドメイン + エイリアス）
│   ├── accounts.md        # アカウント統合・認証・パスワード管理
│   └── storage.md         # ファイル/写真/メモ/ドキュメントの置き場所
├── inventory/             # 現状の台帳（As-Is）
│   ├── services.md        # 利用サービス一覧
│   └── email-aliases.md   # エイリアス台帳
├── decisions/             # 決定記録（ADR形式、YYYY-MM-DD-slug.md）
├── projects/              # 進行中の移行・プロジェクト計画（YYYY-MM-slug.md）
└── templates/             # 新規ルール/決定記録のひな形
```

## 運用

1. 何か新しく作る/登録する前に、該当する `rules/*.md` を見る（またはClaudeに聞く）。
2. 作った/登録したら `inventory/*.md` に1行追記する。
3. ルールを変えたら `decisions/` に理由を残し、`rules/` を更新する。
