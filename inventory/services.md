# 利用サービス台帳

新規登録・メール変更・解約のたびに1行更新する。秘密情報は書かない。

| サービス | カテゴリ | ログインID（メール） | 認証 | 支払い | 状態 | 更新日 | メモ |
|---|---|---|---|---|---|---|---|
| Proton Mail | dev | `bl5e44j@proton.me` | PW+YubiKey(+Bitwardenパスキー/Windows Hello) | Mail Plus 12か月 | 利用中 | 2026-11-15 | メール基盤。Tier 0 |
| Bitwarden | dev | `bl5e44j+infra@gmail.com` | パスキー（YubiKey/Pixel 9a/Windows Hello）+2段階ログイン | 勤務先スポンサー（Families） | 利用中 | 2026-11-14 | パスワード・パスキー管理。Tier 0 |
| Cloudflare | dev | `bl5e44j+dev@gmail.com`（→ `+infra` へ変更予定。`@bluemoment.fyi` 不可） | PW+YubiKey/Bitwardenパスキー/Windows Hello | TBD | 利用中 | 2026-11-14 | レジストラ+DNS: bluemoment.fyi / bluemoment.studio |
| Claude (claude.ai) | dev | `bluemoment20@gmail.com`（**メール変更不可**: 公式に未対応 2026-11-15 確認） | TBD | TBD | 移行中 | 2026-11-15 | 新アカウントへ移行予定（[projects/2026-11-claude-account-migration.md](../projects/2026-11-claude-account-migration.md)） |
| GitHub | dev | `bl5e44j+dev@gmail.com`（据え置き。開発基盤のため独自ドメインに依存させない） | パスキー（Bitwarden/YubiKey） | 無料 | 利用中 | 2026-11-15 | このリポジトリ（AkihisaOnuki/life-rules） |
| ジブラルタ生命 | finance | `gibraltar@bluemoment.fyi` | TBD | TBD | 利用中 | 2026-11-15 | 2026-11-15 メール変更済 |
| Microsoft アカウント | infra | `bl5e44j@gmail.com`（据え置き推奨: 独自ドメイン非依存で既に条件を満たす） | TBD | - | 利用中 | 2026-11-16 | Windows ログイン / Windows Hello。パスキー・YubiKey 追加とリカバリー確認が未 |
| povo2.0 | infra | `bl5e44j` 系のどれか（要確認） | TBD | TBD | 利用中 | 2026-11-16 | SMS 受け口。独自ドメイン非依存のまま（`+infra` 推奨） |
| 八十二銀行 | finance | bm20 or bl5e44j（要確認） → `hachijuni@bluemoment.fyi` | TBD | - | 移行予定 | 2026-11-16 | |
| Olive（三井住友銀行） | finance | `smbc@bluemoment.fyi` | TBD | - | 利用中 | 2026-11-18 | 2026-11-18 メール変更済。カード一体型（Vpass） |
| 住信SBIネット銀行 | finance | bm20 or bl5e44j（要確認） → `sbi-bank@bluemoment.fyi` | TBD | - | 移行予定 | 2026-11-16 | |
| SBI証券 | finance | bm20 or bl5e44j（要確認） → `sbi-sec@bluemoment.fyi` | TBD | - | 移行予定 | 2026-11-16 | NISA |
| りそな銀行 | finance | bm20 or bl5e44j（要確認） → `resona@bluemoment.fyi` | TBD | - | 移行予定 | 2026-11-16 | |
| クレジットカード（各社） | finance | 多くは bm20（推定） | TBD | - | 棚卸し待ち | 2026-11-16 | 一覧未把握。口座の引き落とし明細・Gmail「ご利用明細」検索で洗い出す |
| ソニー損保 | finance | `sonysonpo@bluemoment.fyi` | PW+パスキー（Bitwarden） | TBD | 利用中 | 2026-11-18 | 2026-11-18 メール変更済 |
| 保険（ジブラルタ・ソニー損保以外） | finance | 多くは bm20（推定） | TBD | - | 棚卸し待ち | 2026-11-16 | |
| ConoHa | dev | `conoha@bluemoment.fyi` | PW+TOTP/パスキー（Bitwarden） | VPS 契約は 2027-02 で終了予定 | 利用中（アカウント維持） | 2026-11-18 | 本番インフラは置いていないため独自ドメインで可。本番用途に使う場合は `+dev` へ変更 |
| Amazon | shop | `amazon@bluemoment.fyi` | TBD | TBD | 利用中 | 2026-11-15 | 2026-11-15 メール変更済 |

- 状態: `利用中` / `移行中`（旧メール→新メール） / `解約予定` / `解約済`
- 認証: `PW+TOTP` / `パスキー` / `Googleログイン` など
