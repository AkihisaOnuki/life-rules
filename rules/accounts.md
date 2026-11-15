# アカウント・認証ルール

> ステータス: 整理中（複数Googleアカウント → 統合）

## 1. 方針
- Googleアカウントは **主アカウント1つに寄せる**。用途別アカウントは段階的に廃止。
- サービスのログインIDは [email.md](email.md) のルールで発行したアドレスを使う。
- 「Googleでログイン」等のソーシャルログインは原則使わない（アカウント統合・削除時に詰むため）。例外は inventory に明記。

## 2. 認証
| 項目 | ルール |
|---|---|
| パスワード管理 | **Bitwarden**（Families プラン。勤務先 Enterprise の Families スポンサー枠）に全件登録。パスキーも Bitwarden に保存してよい（[決定記録](../decisions/2026-11-14-passkeys-in-bitwarden.md)） |
| 認証の要（ルート・オブ・トラスト） | **YubiKey 5C**（FIDO2/WebAuthn） |
| 2FA 優先順位 | ① パスキー（Bitwarden or YubiKey） ② セキュリティキー（YubiKey） ③ TOTP ④ SMS（他に手段が無い場合のみ） |
| TOTPの保管先 | 原則 Bitwarden の TOTP 欄。ただし **Bitwarden 自身・Proton・Cloudflare・メインGoogle の TOTP は Bitwarden に入れない**（下記 §2.1） |
| リカバリーコード | 紙に印刷して自宅保管（場所名: TBD）。Bitwarden 自身の2FAリカバリーコードは Bitwarden 外に必ず置く |
| サービス↔メールアドレスの対応 | Bitwarden の各エントリの「ユーザー名」を正とする。台帳 [inventory/services.md](../inventory/services.md) は索引 |

### 2.1 Tier 0（これを失うと他が全部復旧できない）
- 対象: **Bitwarden / Proton / Cloudflare / メインGoogle**
- ルール:
  - YubiKey を2FAに登録し、TOTP やリカバリーは Bitwarden の外に置く（Bitwarden が開けない時に詰むため）。
  - YubiKey 登録済みなら、**利便用の追加2FA として Bitwarden パスキー / Windows Hello の登録も可**（2026-11-14）。Bitwarden 侵害時は元々全滅なので被害範囲は増えない。Windows Hello は登録PC専用・家族と共用しないWindowsアカウントに限る。
  - 例外: **Bitwarden 自身の2FAに Bitwarden パスキーは不可**（自己参照）。
  - Bitwarden のマスターパスワードと 2FA リカバリーコードは紙で保管。
  - Tier 0 同士でログインメールを循環させない（例: Cloudflare のログインを `@bluemoment.fyi` にしない）。
  - 独自ドメインに依存させたくないアカウントはメインGmailの `+` で分ける（独自ドメイン不可）:
    - `bl5e44j+infra@gmail.com`: レジストラ・DNS・Bitwarden・Proton のリカバリー等（2026-11-14）
    - `bl5e44j+dev@gmail.com`: 開発基盤（GitHub 等。このリポジトリがあるため）（2026-11-15）

### 2.2 YubiKey 運用
- **YubiKey は2本体制にする**（1本は常用、1本は自宅保管の予備）。1本運用は単一障害点。紛失・故障で Tier 0 に入れなくなる。
  - 予備は Tier 0 全部に「両方とも」登録する。新サービス追加時も両方登録。
- 現状: 1本（YubiKey 5C）。予備なし（2026-11-14 確認）。購入タスクは [projects/2026-11-proton-migration.md P0](../projects/2026-11-proton-migration.md)。

### 2.3 Bitwarden スポンサー枠のリスク
- Families スポンサーは **勤務先に在籍している間のみ**。退職・会社の契約変更で失効する。
- 失効時: 個人で Families（年額）を契約して継続する。データは個人 Vault / 組織 Vault にあるため、組織（Families）Vault の中身は失効前に移行可否を確認する。
- 退職時チェックリストに「Bitwarden スポンサー切替」を入れる。

### 2.4 Bitwarden のメール生成機能
- Generator → Username → **Catch-all email** でドメイン `bluemoment.fyi` を指定するとランダムなアドレスを生成できる。
- ただし命名規則は [email.md §2](email.md)（`<service>@`）を優先。ランダム生成は `temp` 用途のみ可。

## 3. Googleアカウント一覧（現状）
| アカウント（識別名） | 用途 | 状態 | 統合先 / 対応 |
|---|---|---|---|
| main（`bl5e44j@gmail.com`） | 主。Android/Play Console、Tier 0 のログイン/リカバリー用メール | 存続 | **転送・取込はしない**（2026-11-15）。役割＝Google/Android＋インフラ系ログイン（`+infra`）＋過去メール書庫。一般サービスは個別に Proton へ移す |
| bm20（`bluemoment20@gmail.com`） | Claude.ai ログイン（変更不可）他。Cloudflare は移行済 | **削除予定 → 保留**（Claude の扱い次第） | Easy Switch で転送（設定済） → 全サービス変更 → 転送ラベルに3か月来なければ §4 チェック後に削除 |
| （例）sub-old | 旧用途 | 統合予定 | main へデータ移行後削除 |

※ アドレス全文を書くかは任意（privateリポジトリ前提）。

## 4. アカウント削除前チェック
- [ ] そのアカウントでログインしているサービスが無いか（ソーシャルログイン含む）
- [ ] Google Drive / Photos / Keep のデータ移行済み
- [ ] 購入履歴（Play ストア等）の扱いを確認
- [ ] 他サービスの復旧用メールに使われていないか
