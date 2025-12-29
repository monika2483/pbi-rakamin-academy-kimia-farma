--Cek duplikat
SELECT transaction_id, COUNT(*) AS total_row
FROM `rakamin-kf-analytics-481805.kimia_farma.kf_tabel_analisa`
GROUP BY transaction_id
HAVING COUNT(*) > 1;

--Cek missing value
SELECT
  COUNTIF(transaction_id IS NULL) AS null_transaction_id,
  COUNTIF(date IS NULL) AS null_date,
  COUNTIF(branch_id IS NULL) AS null_branch_id,
  COUNTIF(branch_name IS NULL) AS null_branch_name,
  COUNTIF(kota IS NULL) AS null_kota,
  COUNTIF(provinsi IS NULL) AS null_provinsi,
  COUNTIF(rating_cabang IS NULL) AS null_rating_cabang,
  COUNTIF(customer_name IS NULL) AS null_customer_name,
  COUNTIF(product_id IS NULL) AS null_product_id,
  COUNTIF(product_name IS NULL) AS null_product_name,
  COUNTIF(actual_price IS NULL) AS null_actual_price,
  COUNTIF(discount_percentage IS NULL) AS null_discount,
  COUNTIF(rating_transaksi IS NULL) AS null_rating_transaksi
FROM `rakamin-kf-analytics-481805.kimia_farma.kf_tabel_analisa`;

--Cek nilai aneh
SELECT *
FROM `rakamin-kf-analytics-481805.kimia_farma.kf_tabel_analisa`
WHERE nett_sales < 0
   OR nett_profit < 0;