# メール運用ルール

> ステータス: **移行中**（Gmail + `+` エイリアス → Proton Mail + 独自ドメイン + エイリアス）
> 決定記録: [decisions/2026-11-14-proton-mail-custom-domain.md](../decisions/2026-11-14-proton-mail-custom-domain.md), [decisions/2026-11-14-proton-plan-and-catch-all.md](../decisions/2026-11-14-proton-plan-and-catch-all.md)
> 移行計画: [projects/2026-11-proton-migration.md](../projects/2026-11-proton-migration.md)

## 1. 基本構成（To-Be）
| 項目 | 値 |
|---|---|
| メールサービス | Proton Mail Plus（推奨・未契約） |
| 独自ドメイン | `bluemoment.fyi`（Cloudflare 取得済・DNSもCloudflare）。個人メール専用 |
| 受信方式 | **catch-all 有効**（宛先 `me@`）。送信が必要なアドレスだけ個別作成（上限10） |
| 主アドレス（人に教える用） | `me@bluemoment.fyi` |
| Proton アカウントID | `<name>@proton.me` |
| Tier 0 のログイン/リカバリー用メール | **メインGoogle `bl5e44j@gmail.com`**（Cloudflare・Proton リカバリー等、`bluemoment.fyi` が死んだ時に必要なものはこちら） |
| 使わないドメイン | `bluemoment.studio`（プロジェクトWeb用。個人のサービス登録に使わない。[domains.md](domains.md)） |
| 旧Gmail | 移行完了まで転送で受信、新規登録には使わない |

## 2. アドレスの決め方
- 書式: `<プレフィックス>-<サービス名>@bluemoment.fyi`
  - 例: `shop-amazon@bluemoment.fyi`, `finance-sbi@bluemoment.fyi`, `dev-github@bluemoment.fyi`
- プレフィックスは [00-principles.md §3](00-principles.md) の一覧から選ぶ。
- **1サービス1アドレス**。漏洩・スパム発生時はそのアドレスだけ無効化する。
- 人に教えるアドレスは `me@` 系に限定する。
- 使い捨ては `temp-<YYYYMM>-<用途>@bluemoment.fyi`。

## 3. 新規登録時の手順
1. §2 の書式でアドレスを決める。
2. catch-all なので Proton 側の作成は不要。**そのアドレスから送信/返信が必要な場合のみ** Proton でアドレスを個別作成。
3. パスワードマネージャに登録（アカウント名にアドレスを使う）。
4. [inventory/email-aliases.md](../inventory/email-aliases.md) と [inventory/services.md](../inventory/services.md) に追記。

## 4. フォルダ/ラベル
- プレフィックス単位でラベル（`finance`, `shop` …）を作り、受信先アドレスでフィルタ振り分け。

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
