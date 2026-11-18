# メール運用ルール

> ステータス: **移行中**（Gmail + `+` エイリアス → Proton Mail + 独自ドメイン + エイリアス）
> 決定記録: [decisions/2026-11-14-proton-mail-custom-domain.md](../decisions/2026-11-14-proton-mail-custom-domain.md), [decisions/2026-11-14-proton-plan-and-catch-all.md](../decisions/2026-11-14-proton-plan-and-catch-all.md)
> 移行計画: [projects/2026-11-proton-migration.md](../projects/2026-11-proton-migration.md)

## 1. 基本構成（To-Be）
| 項目 | 値 |
|---|---|
| メールサービス | Proton Mail Plus（推奨・未契約） |
| 独自ドメイン | `bluemoment.fyi`（Cloudflare 取得済・DNSもCloudflare）。個人メール専用 |
| 受信方式 | **catch-all 有効**（宛先 `akihisa.onuki@`）。送信が必要なアドレスだけ個別作成（上限10） |
| 主アドレス（人に教える用） | `akihisa.onuki@bluemoment.fyi` |
| Proton アカウントID | `bl5e44j@proton.me` |
| Tier 0 のログイン/リカバリー用メール | **メインGoogle `bl5e44j@gmail.com`**（Cloudflare・Proton リカバリー等、`bluemoment.fyi` が死んだ時に必要なものはこちら） |
| 使わないドメイン | `bluemoment.studio`（プロジェクトWeb用。個人のサービス登録に使わない。[domains.md](domains.md)） |
| 旧Gmail | 移行完了まで転送で受信、新規登録には使わない |

## 2. アドレスの決め方
- 書式: **`<サービス名>@bluemoment.fyi`**（プレフィックス無し。2026-11-15 変更、[決定記録](../decisions/2026-11-15-email-no-prefix.md)）
  - 例: `amazon@bluemoment.fyi`, `gibraltar@bluemoment.fyi`, `sbi@bluemoment.fyi`, `rakuten-bank@bluemoment.fyi`
  - サービス名は小文字・kebab-case。短く、そのサービスと一目で分かる名前にする。
- カテゴリ（`finance`, `shop` 等）はアドレスに入れず、台帳の「カテゴリ」列と Proton のラベルで管理する。
- **1サービス1アドレス**。漏洩・スパム発生時はそのアドレスだけ無効化する。
- 人に教えるアドレスは `akihisa.onuki@bluemoment.fyi` に限定する（catch-all 宛先を兼ねる）。
- 使い捨ては `temp-<YYYYMM>-<用途>@bluemoment.fyi`。

## 2.5 独自ドメインを使わないもの
- Tier 0・インフラ・開発基盤は `bluemoment.fyi` を使わず、メインGmailの `+infra` / `+dev` を使う（[accounts.md §2.1](accounts.md)）。
  - 理由: ドメイン失効・Proton 障害時でも復旧経路を残すため。

## 2.6 過去メールの扱い
- 原則、過去メールは Gmail に残す（書庫）。サービスの注文履歴・領収書はサービス側で再取得できる。
- どうしても Proton に置きたい場合: Gmail で `from:<送信元ドメイン>` のフィルタを作り既存メールにもラベル付与 → Easy Switch でそのラベルだけ取込（一回限り）。

## 3. 新規登録時の手順
1. §2 の書式でアドレスを決める。
2. catch-all なので Proton 側の作成は不要。**そのアドレスから送信/返信が必要な場合のみ** Proton でアドレスを個別作成。
3. パスワードマネージャに登録（アカウント名にアドレスを使う）。
4. [inventory/email-aliases.md](../inventory/email-aliases.md) と [inventory/services.md](../inventory/services.md) に追記。

## 4. フォルダ/ラベル
- カテゴリ単位でラベル（`finance`, `shop` …、[00-principles.md §3](00-principles.md)）を作る。
- **サービス単位のラベルは作らない**。アドレス自体が索引なので `to:amazon@bluemoment.fyi` で検索する。
- ラベルは重要カテゴリのみ: `Finance`（銀行・証券・カード・保険）、`Family`（保育園・行政・家族）。
- **漏洩検知**: 宛先アドレスごとに想定差出人ドメインを定義し、想定外の差出人なら `漏洩疑い` ラベル。台帳 [inventory/email-aliases.md](../inventory/email-aliases.md) の「想定差出人ドメイン」列が正。漏洩確定したらそのアドレスを遮断（§4.5）し、サービス側のアドレスを変更。
- 振り分けは Sieve で管理し、正本は [config/proton/labels.sieve](../config/proton/labels.sieve)。finance/family のアドレスを追加したら Claude が更新 → Proton に貼り直す。

## 4.5 遮断
- 漏洩・スパム化したアドレスは Sieve フィルタで拒否し、台帳の状態を `無効化` にする。
- `info@`, `admin@`, `contact@`, `support@`, `sales@` 等の汎用名は既定で拒否（catch-all への辞書攻撃対策）。

## 5. 移行手順（チェックリスト）
詳細手順は [projects/2026-11-proton-migration.md](../projects/2026-11-proton-migration.md)。
- [ ] ドメイン決定・取得
- [ ] Proton プラン決定・契約
- [ ] DNS 設定（MX / SPF / DKIM / DMARC）
- [ ] 主アドレス作成、送受信テスト
- [ ] Gmail → Proton 転送 or Proton の Gmail 転送機能を設定
- [ ] 重要度順にサービスのメールアドレスを変更（finance → family → dev → shop → その他）
- [ ] 変更したサービスを inventory に記録
- [ ] 旧Googleアカウントの整理・削除判断（[accounts.md](accounts.md)）

## 6. 注意
- ドメイン失効 = 全アカウントのメール喪失。**ドメインは自動更新 + 複数年契約**、レジストラのログインは強固な2FA。
- ドメイン/レジストラのアカウント自体のメールは、そのドメイン以外（例: Protonの `@proton.me` アドレス）にする（循環依存の回避）。
