# Proton Mail 移行プロジェクト（2026-11〜）

- ゴール: Gmail（複数Googleアカウント + `+`エイリアス）→ Proton Mail + 独自ドメイン + catch-all に一本化
- ルール（To-Be）: [rules/email.md](../rules/email.md)
- 決定記録: [decisions/2026-11-14-proton-mail-custom-domain.md](../decisions/2026-11-14-proton-mail-custom-domain.md), [decisions/2026-11-14-proton-plan-and-catch-all.md](../decisions/2026-11-14-proton-plan-and-catch-all.md)
- 調査日: 2026-11-14（価格・上限は Proton 公式ページで確認。変動するので契約時に再確認）

---

## 0. 結論（推奨構成）

| 項目 | 推奨 | 理由 |
|---|---|---|
| プラン | **Proton Mail Plus**（12か月） | 独自ドメイン1個 + catch-all で受信アドレスは実質無制限。最安。 |
| ドメイン | **`bluemoment.fyi`（取得済）** | 個人メール専用。`bluemoment.studio` はプロジェクトWeb用で混ぜない（[rules/domains.md](../rules/domains.md)） |
| レジストラ / DNS | **Cloudflare（取得済）** | 原価更新・DNS同居。そのまま使う |
| 受信方式 | **catch-all ON** + 送信が必要なアドレスだけ個別作成 | Mail Plus の個別アドレス上限（10）を「送信用」にだけ使う |
| 大量の使い捨て | catch-all で `temp-...@` を即興で使う | Proton Pass の hide-my-email は Mail Plus だと10個まで |

### プラン比較（2026-11-14 時点、USD、12か月払い）

| プラン | 初年度 | 2年目以降 | 独自ドメイン | 個別アドレス | catch-all | hide-my-email |
|---|---|---|---|---|---|---|
| Mail Plus | $29.88（$2.49/月） | $47.88/年 | 1 | 10 | ○ | 10 |
| Proton Unlimited | $77.88（$6.49/月） | $119.88/年 | 3 | 15 | ○ | 無制限 |
| Pass Plus（参考） | $1.99/月 | $35.88/年 | 無制限（エイリアス用） | – | ○ | 無制限 |

- 2026-11 は Black Friday 割引（50% off 表示）中。**初年度だけ安く、更新価格は別**。年額で比較すること。
- Unlimited に上げる判断基準: Drive（500GB）/ VPN / Pass の無制限エイリアスを「全部使う」なら。メールだけなら Mail Plus で十分。
- `+` サブアドレス（`akihisa.onuki+xxx@bluemoment.fyi`）も全プランで使える。ただし移行動機が「`+`非対応サービス」なので主には使わない。

### Mail Plus + catch-all の要点（インフラ的に言うと）

- catch-all = **デフォルトルート**。個別アドレス = **静的ルート（ロンゲストマッチ優先）**。個別に作ったアドレスが優先され、それ以外は全部 catch-all 宛先（`akihisa.onuki@`）のメールボックスに落ちる。
- **受信は無制限、送信は個別作成したアドレスのみ**。`shop-amazon@` から返信したくなったら、その時点でアドレスを作る（10枠の範囲で）。
- 漏洩・スパム化したアドレスの遮断は **Sieve フィルタで reject/削除**（＝ACL で deny）。個別アドレスとして作成→無効化でも止められる可能性があるが、挙動は要検証。
- リスク: 辞書攻撃的なスパム（`info@`, `admin@` 等）も全部受ける → `info|admin|contact|support|sales|noreply` などは Sieve で既定拒否。

---

## 1. フェーズ別ロードマップ

| Phase | 内容 | 目安期間 | 完了条件 |
|---|---|---|---|
| P0 | ドメイン取得・Proton契約 | 1日 | ドメイン取得済、Mail Plus 契約済 |
| P1 | DNS設定・アドレス作成・疎通確認 | 1〜2日 | 全レコード緑、外部との送受信OK、DMARCレポート受信 |
| P2 | Gmail取込・転送設定（並行運用開始） | 1日 | 旧Gmail宛が全てProtonに届く |
| P3 | サービスのメール変更（重要度順） | 1〜3か月 | Tier A/B 完了 |
| P4 | 並行運用の監視・残り移行 | 〜6か月 | 旧Gmail宛の新着が月数通以下 |
| P5 | Googleアカウント整理 | 移行開始から1年後 | 残すアカウント1つに集約 |

---

## P0. ドメイン確認・契約

- [x] ドメイン取得: `bluemoment.fyi`（Cloudflare Registrar）
- [x] Cloudflare で `bluemoment.fyi` の **Auto Renew ON** を確認（Domain Registration → Manage）
- [x] Cloudflare アカウントの2FA: セキュリティキー（YubiKey / Bitwarden / Windows Hello）登録済、リカバリーコード印刷済（2026-11-15）
- [x] Cloudflare のログインメールは `bl5e44j+dev@gmail.com`（変更済）。
- [ ] （後回しOK）Cloudflare のログインメールを `bl5e44j+infra@gmail.com` に変更
- [ ] **Cloudflare のログイン以外のメール** を `bl5e44j+infra@gmail.com` に変更（2026-11-14 発覚: 領収書が bm20 に届いた）
  - [x] Billing → 請求先/領収書の送付先メール（2026-11-15）
  - [x] Domain Registration → デフォルト連絡先（2026-11-15）
  - 既存ドメインごとの連絡先（Registrant / Admin / Tech / Billing）を `+infra` に ← 失効・移管通知が届く。最重要
    - [x] bluemoment.fyi（2026-11-15 反映済）
    - [ ] bluemoment.studio（2026-11-15 確認メール承認済、反映待ち。翌日以降に再確認）
  - WHOIS は Cloudflare により秘匿（REDACTED）済み＝正常
  - [x] Notifications: アラート未使用のため対応不要
  - **`@bluemoment.fyi` には絶対にしない**（循環依存: ドメイン死亡→Cloudflareに入れない→復旧不能）
- [x] Proton のリカバリー用メール: `bl5e44j+infra@gmail.com`（2026-11-15）
- [ ] **予備 YubiKey を購入**（推奨: Security Key C NFC＝FIDO2専用で安価、または 5C NFC＝TOTP/PIVも使う場合。Android でNFCが使えるNFC版を選ぶ。購入は Yubico 公式 or 正規代理店）。届いたら Tier 0（Bitwarden / Proton / Cloudflare / メインGoogle）に2本とも登録。Proton は届いてから2FA登録すると1回で済む
- [ ] 支払いカードの有効期限をカレンダー登録（自動更新失敗＝メール全滅の最大要因）
- [ ] （任意）`.fyi` は新しめのgTLD。まれにアドレス入力欄の検証で弾くサービスがある → 発生したら台帳に記録し `@proton.me` を使う
- [x] Proton アカウント作成（`<name>@proton.me`）→ Mail Plus 契約
  - Proton の2FAは **YubiKey（FIDO2）** を登録。リカバリーフレーズは紙で保管（Tier 0 のため Bitwarden の外。[rules/accounts.md §2.1](../rules/accounts.md)）
  - Proton のログイン情報自体は Bitwarden に登録

## P1. DNS設定・アドレス作成

**値は Proton 管理画面（Settings → Domain names → Add domain）の表示を正とする。** 以下は形の確認用。

| 種別 | ホスト | 値（例） | 備考 |
|---|---|---|---|
| TXT | `@` | `protonmail-verification=xxxxxxxx` | ドメイン所有確認 |
| MX | `@` | `mail.protonmail.ch`（優先度 10） | |
| MX | `@` | `mailsec.protonmail.ch`（優先度 20） | |
| TXT | `@` | `v=spf1 include:_spf.protonmail.ch ~all` | SPFは**1レコードのみ**。安定後 `-all` を検討 |
| CNAME | `protonmail._domainkey` | 管理画面の値 | DKIM 1/3 |
| CNAME | `protonmail2._domainkey` | 管理画面の値 | DKIM 2/3 |
| CNAME | `protonmail3._domainkey` | 管理画面の値 | DKIM 3/3 |
| TXT | `_dmarc` | Proton 提示値（`v=DMARC1; p=quarantine`） | 新規ドメインで送信元は Proton のみのため監視フェーズ省略（2026-11-14 変更） |

- Cloudflare DNS の場合、CNAME は **プロキシOFF（DNS only / グレー雲）**。オレンジ雲だと DKIM が壊れる。
- TTL は作業中 300 秒、安定後 Auto/3600。
- DMARC: `p=quarantine` で開始 → 数か月問題なければ `p=reject`。

事前確認（Cloudflare ダッシュボード → bluemoment.fyi → DNS / Email）:
- [x] **Cloudflare Email Routing が有効なら無効化**（`route1/2/3.mx.cloudflare.net` のMXとSPFを自動管理・ロックするため Proton の MX と競合する）
- [x] 既存の MX / SPF（`v=spf1`で始まるTXT）/ `_dmarc` があれば控えてから削除・置換（SPFは1レコードのみ）

手順:
- [x] TXT（verification）→ 検証通過
- [x] **MX を向ける前に** 送信が必要なアドレスを作成（`akihisa.onuki@`, `family-*@` など。上限10）
- [x] MX / SPF / DKIM / DMARC 投入 → 管理画面で全て緑
- [x] catch-all を ON（Settings → Domain names → Actions → Set catch-all、宛先 `akihisa.onuki@`）
- [ ] Sieve で既定拒否リスト設定（`info@`, `admin@`, `postmaster@` 以外の汎用名など）
- [x] 疎通テスト（2026-11-14 全項目OK）
  - 外部（Gmail）→ `akihisa.onuki@` / `適当な文字列@`（catch-all）に届くか
  - `akihisa.onuki@` → Gmail に送信し、ヘッダで `spf=pass dkim=pass dmarc=pass` を確認
  - `dig MX bluemoment.fyi`, `dig TXT _dmarc.bluemoment.fyi` で外部から見えるか
- [ ] Proton のラベル/フォルダ・振り分けフィルタを作成（プレフィックス単位、[rules/email.md §4](../rules/email.md)）

## P2. Gmail 転送・並行運用開始

方針: **過去メールは移行しない**（Gmail を書庫として残す）。Easy Switch での取込は、そのGoogleアカウントを削除する時（P5）だけ実施。

- [ ] 各 Gmail で自動転送を設定（アカウントごとに）
  1. Gmail 設定 → 「メール転送と POP/IMAP」→「転送先アドレスを追加」→ `legacy-<識別名>@bluemoment.fyi`（catch-all なので作成不要）
  2. 確認コードが Proton に届く → Gmail に入力
  3. 「受信メールのコピーを転送して、Gmail のメールをアーカイブする」を選択 → 保存（削除はしない＝保険）
- [ ] Proton でフィルタ作成: 条件「受信者（Recipient）に `@gmail.com` を含む」→ ラベル `未移行`
  - 転送メールは To ヘッダが元の Gmail アドレスのまま残るため、これで判別できる（BCC系メルマガは漏れるが許容）
  - **このラベルに来たもの＝まだアドレス変更していないサービス** の作業リスト
- [ ] 転送確認: 別アドレスから各 Gmail へ送り、Proton の `未移行` に入るか

### P2 アカウント別の扱い（2026-11-14 決定）
| 順 | アカウント | 転送先 | 過去メール | 最終形 |
|---|---|---|---|---|
| 1 | bm20（`bluemoment20@gmail.com`） | **Easy Switch の転送で設定済（2026-11-14）**。転送メールには Easy Switch が自動でラベルを付ける → これを `未移行` リストとして使う | Easy Switch で取込 | **アカウント削除** |
| 2 | main（`bl5e44j@gmail.com`） | **転送しない**（2026-11-15 決定。`+infra` 宛まで Proton に流れると循環依存になるため） | **取込しない**（量が多い・重要物あり。Gmail を書庫として残す） | アカウント存続。役割＝Google/Android＋インフラ系ログイン（`+infra`）＋過去メール書庫。一般サービスは P3 で個別に Proton へ移し、自然に縮小させる |

- 手動転送より Easy Switch（Settings → Import via Easy Switch → Google）を優先。OAuthで転送設定・取込・ラベル付けまで自動。

## P3. サービスのメールアドレス変更（重要度順）

| Tier | 対象 | 理由 | 時期 |
|---|---|---|---|
| A | 銀行・証券・カード・保険・携帯キャリア・行政（マイナポータル、e-Tax 等）・パスワードマネージャ・Apple/Microsoft | 失うと復旧困難。本人確認通知が来る | P2直後〜1か月 |
| B | 保育園・家族関係、仕事、GitHub・クラウド・開発系（Play Console 等） | 連絡が来る・業務影響 | 〜2か月 |
| C | EC・サブスク | 決済連携あり | 〜3か月 |
| D | メルマガ・ニュース | 変更せず**解約**を優先 | 随時 |

1サービスあたりの作業:
1. [rules/email.md §2](../rules/email.md) の書式でアドレスを決める（catch-all なので Proton 側の作成は不要）
2. サービスの設定でメール変更 → 確認メールが Proton に届くことを確認
   - **ログイン用とは別の「請求・通知・連絡先」メール欄**も確認して変更（例: Cloudflare の Billing / Registrant）
3. Bitwarden のエントリの「ユーザー名」を新アドレスに更新（これが対応表の正本）
4. [inventory/services.md](../inventory/services.md) / [inventory/email-aliases.md](../inventory/email-aliases.md) に追記

注意:
- メール変更時に **旧アドレスへ確認が飛ぶ**サービスがある → 並行運用中なので転送で受けられる（P2を先に済ませる理由）。
- ログインIDがメールアドレス固定のサービス（変更不可）は、新規アカウント作り直しか、旧Gmailのまま台帳に「変更不可」と記録。
- 「Googleでログイン」連携しているサービスは、メールだけでなく**ログイン手段の付け替え**（パスワード or パスキーへ）が必要か確認。

## P4. 並行運用の監視

- 月1回、`未移行` ラベルの差出人を確認 → 残りを移行 or 解約
- 終了条件: 旧Gmail宛の正規メールが **2か月連続で0〜数通**
- 終了後も **Gmail 転送は最低1年残す**（年1回しか来ない通知: 税・保険・ドメイン以外の年次更新など を拾うため）

## P5. Google アカウント整理

- 残す: **Android / Google Play / Play Console 用のメイン1アカウント**（Android 開発・端末に必須）
- それ以外: 転送1年経過後、Googleデータエクスポート（Takeout）→ 削除判断（[rules/accounts.md](../rules/accounts.md)）
- 参考: Google アカウントは「Gmail サービスのみ削除」してログインIDを独自ドメインのアドレスに切り替える手もある。ただし Gmail アドレスは二度と使えないので、P4 完了後に慎重に。

---

## 2. リスクと対策

| リスク | 対策 |
|---|---|
| ドメイン失効 | 自動更新・複数年・カード期限のカレンダー登録・レジストラのログインは `@proton.me` |
| Proton アカウントロック/障害 | リカバリーフレーズ保管。ドメインは自分の資産なので MX を他社に向ければ復旧可能（ポータビリティ） |
| catch-all へのスパム | Sieve で既定拒否 + 漏洩アドレスを個別遮断 |
| 送信アドレス枠（10）不足 | 返信不要なものは受信専用で運用。枠が足りなくなったら Unlimited（15）へ |
| 一部サービスで独自ドメイン拒否 | ほぼ無いが、発生したら台帳に記録し `@proton.me` を使用 |
