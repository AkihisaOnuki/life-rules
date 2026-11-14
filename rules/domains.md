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
  - 決定: **メインGoogleの Gmail（`bl5e44j@gmail.com`）** を使う。旧 `bluemoment20@gmail.com` から変更予定（2026-11-14）。

## 3. メールを送らないドメインの防御（なりすまし対策）
メールを使わないドメインには以下を必ず入れる。

| 種別 | ホスト | 値 |
|---|---|---|
| MX | `@` | `.`（優先度 0, Null MX: RFC 7505） |
| TXT | `@` | `v=spf1 -all` |
| TXT | `_dmarc` | `v=DMARC1; p=reject;` |

- `bluemoment.studio` が該当（2026-11-14 時点で送受信予定なし）。

## 4. プロジェクト用の連絡先が必要になったら
- 受信のみ: Cloudflare Email Routing で `contact@bluemoment.studio` → `me@bluemoment.fyi` に転送（無料）。§3 の Null MX は外し、SPF/DMARCは Email Routing の指示に合わせる。
- 送信も必要: Proton Unlimited（独自ドメイン3つ）に上げて Proton に追加。
