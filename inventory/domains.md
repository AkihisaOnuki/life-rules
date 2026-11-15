# ドメイン台帳

ルールは [rules/domains.md](../rules/domains.md)。

| ドメイン | 用途 | レジストラ / DNS | 自動更新 | メール | 状態 | 更新日 |
|---|---|---|---|---|---|---|
| `bluemoment.fyi` | 個人メール（Proton） | Cloudflare / Cloudflare | ON | Proton（MX/SPF/DKIM/DMARC 設定済、catch-all ON） | 利用中 | 2026-11-15 |
| `bluemoment.studio` | bluemoment プロジェクトWebサイト | Cloudflare / Cloudflare | 要確認 | Cloudflare Email Routing → `bl5e44j+dev@gmail.com`（受信のみ。DMARC `p=reject` 要確認） | 利用中 | 2026-11-16 |
