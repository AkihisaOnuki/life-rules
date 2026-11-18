# Proton Mail フィルタ（Sieve）— カテゴリ別ラベル ＋ 漏洩検知
# 正本: このファイル。Proton → 設定 → フィルタ → 「Sieve フィルタを追加」に全文を貼る。
# 更新: inventory/email-aliases.md の「想定差出人ドメイン」を更新したら、ここにも反映して貼り直す（Claude が更新する）。
# 事前に Proton でラベルを作成: Finance, Family, 漏洩疑い
#
# 考え方: 漏洩 = 「宛先アドレス」と「差出人ドメイン」の組み合わせが想定外であること。
#   宛先 smbc@ に smbc.co.jp 以外から届いた → そのアドレスが漏れた/売られた疑い。
#   差出人だけ・宛先だけでは判定できないので、両方を見る。
require ["fileinto", "imap4flags"];

# ============ 漏洩検知（宛先ごとに想定差出人を定義） ============
# 1アドレス=1ブロック。想定ドメインは実際に届いたメールで確認して追記する（サブドメイン含めるなら "*.example.co.jp"）。

if allof (address :is ["to", "cc"] "amazon@bluemoment.fyi",
          not address :domain :matches "from" ["amazon.co.jp", "*.amazon.co.jp", "amazon.com", "*.amazon.com"]) {
    fileinto "漏洩疑い";
}

if allof (address :is ["to", "cc"] "gibraltar@bluemoment.fyi",
          not address :domain :matches "from" ["gib-life.co.jp", "*.gib-life.co.jp"]) {
    fileinto "漏洩疑い";
}

if allof (address :is ["to", "cc"] "conoha@bluemoment.fyi",
          not address :domain :matches "from" ["conoha.jp", "*.conoha.jp"]) {
    fileinto "漏洩疑い";
}

if allof (address :is ["to", "cc"] "sonysonpo@bluemoment.fyi",
          not address :domain :matches "from" ["sonysonpo.co.jp", "*.sonysonpo.co.jp"]) {
    fileinto "漏洩疑い";
}

if allof (address :is ["to", "cc"] "smbc@bluemoment.fyi",
          not address :domain :matches "from" ["smbc.co.jp", "*.smbc.co.jp", "vpass.ne.jp", "*.vpass.ne.jp", "smbc-card.com", "*.smbc-card.com"]) {
    fileinto "漏洩疑い";
}

if allof (address :is ["to", "cc"] "mynaportal@bluemoment.fyi",
          not address :domain :matches "from" ["myna.go.jp", "*.myna.go.jp"]) {
    fileinto "漏洩疑い";
}

# 銀行・証券等は、移行完了後に実際のアドレスと差出人ドメインを確認してから追加する

# ============ カテゴリ別ラベル ============
# --- Finance（銀行・証券・カード・保険） ---
# 移行済みのアドレスだけを書く（予定アドレスは移行完了後に追加）
if address :is ["to", "cc"] [
    "gibraltar@bluemoment.fyi",
    "sonysonpo@bluemoment.fyi",
    "smbc@bluemoment.fyi"
] {
    fileinto "Finance";
}

# --- Family（保育園・行政・家族） ---
if address :is ["to", "cc"] [
    "mynaportal@bluemoment.fyi"
] {
    fileinto "Family";
}
