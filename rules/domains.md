# ドメイン運用ルール

> 一覧（As-Is）: [inventory/domains.md](../inventory/domains.md)

## 1. 用途分離
- **1ドメイン1用途**。個人メールとプロジェクト/公開Webを混ぜない。
  - 個人メール: `bluemoment.fyi`（[email.md](email.md)）
  - bluemoment プロジェクトWeb: `bluemoment.studio`
- 理由: プロジェクト側を譲渡・閉鎖・外部委託しても個人メールに影響させないため。

## 2. 管理
- レジストラ・DNSは Cloudflare に集約する。
- 全ドメイン **Auto Renew ON**。支払いカード期限をカレンダー登録。
- Cloudflare のログインメールは、管理しているドメイン配下のアドレスにしない（循環依存回避）。
  - 決定: **`bl5e44j+infra@gmail.com`**（メインGmailの `+infra`）を使う。現在は `bl5e44j+dev@gmail.com` で、`+infra` へ変更予定（TODO、急がない）。

## 3. メールを送らないドメインの防御（なりすまし対策）
メールを使わないドメインには以下を必ず入れる。

| 種別 | ホスト | 値 |
|---|---|---|
| MX | `@` | `.`（優先度 0, Null MX: RFC 7505） |
| TXT | `@` | `v=spf1 -all` |
| TXT | `_dmarc` | `v=DMARC1; p=reject;` |

- 該当ドメイン: なし（2026-11-16 時点）。

## 4. プロジェクト用の連絡先が必要になったら
- 受信のみ: Cloudflare Email Routing で転送（無料）。SPF は Email Routing が自動追加するもの1行、DMARC は送信しないなら `p=reject`。
  - **`bluemoment.studio` は既にこの構成**（Email Routing → `bl5e44j+dev@gmail.com`、2026-11-16 確認）。プロジェクトの連絡先は開発系として `+dev` で受ける。
- 送信も必要: Proton Unlimited（独自ドメイン3つ）に上げて Proton に追加。
