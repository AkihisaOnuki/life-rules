# 2026-11-15 メインGmail（bl5e44j）は Proton へ転送・取込しない

- ステータス: 採用

## 背景
- 当初案は Easy Switch で過去メール取込＋恒久転送。
- しかし bl5e44j は重要メールが多く量も多い。また `bl5e44j+infra@gmail.com` をインフラ系（Cloudflare・Proton リカバリー等）のログイン/通知先にしたため、丸ごと転送すると Proton の復旧通知が Proton に流れる循環依存になる。

## 決定
- bl5e44j は転送も取込もしない。
- 役割を「Google/Android アカウント＋インフラ系ログイン（`+infra`）＋過去メール書庫」に限定する。
- 一般サービスは P3 で1つずつ Proton（`<service>@bluemoment.fyi`）へ移し、Gmail の受信を自然に減らす。

## 理由
- Tier 0 の復旧経路を Proton から独立させる（[rules/accounts.md §2.1](../rules/accounts.md)）。
- 過去メールの一括移行はコストに見合わない。Gmail の検索で十分。

## 影響・リスク
- 移行期間中は Gmail と Proton の2か所を見る必要がある。
- 将来必要なら、Gmail のフィルタ転送（`-to:bl5e44j+infra@gmail.com` 等で除外）で一部だけ転送する。
