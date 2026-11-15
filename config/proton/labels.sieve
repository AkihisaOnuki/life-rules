# Proton Mail フィルタ（Sieve）— カテゴリ別ラベル付け
# 正本: このファイル。Proton → 設定 → フィルタ → 「Sieve フィルタを追加」に全文を貼る。
# 更新: inventory/email-aliases.md に finance/family のアドレスを追加したら、ここにも追記して貼り直す（Claude が更新する）。
# ラベル名は Proton 側に先に作っておくこと: Finance, Family
require ["fileinto", "imap4flags"];

# --- Finance（銀行・証券・カード・保険） ---
if address :is ["to", "cc"] [
    "gibraltar@bluemoment.fyi",
    "hachijuni@bluemoment.fyi",
    "smbc@bluemoment.fyi",
    "sbi-bank@bluemoment.fyi",
    "sbi-sec@bluemoment.fyi",
    "resona@bluemoment.fyi"
] {
    fileinto "Finance";
}

# --- Family（保育園・行政・家族） ---
# if address :is ["to", "cc"] [
#     "xxx@bluemoment.fyi"
# ] {
#     fileinto "Family";
# }
