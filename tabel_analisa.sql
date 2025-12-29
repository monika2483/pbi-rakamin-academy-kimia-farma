--membuat tabel baru atau menimpa tabel jika sudah ada dari hasil query
CREATE OR REPLACE TABLE `rakamin-kf-analytics-481805.kimia_farma.kf_tabel_analisa` AS
WITH joined_table AS (
  --select kolom kolom yang ingin digabungkan dalam tabel baru
  SELECT 
    ft.transaction_id,
    ft.date,
    ft.branch_id,
    kc.branch_name,
    kc.branch_category,
    kc.kota,
    kc.provinsi,
    kc.rating AS rating_cabang,
    ft.customer_name,
    p.product_id,
    p.product_name,
    ft.price AS actual_price,
    ft.discount_percentage,

    --pengkondisian persentase gross laba berdasarkan actual price
    CASE 
      WHEN ft.price <= 50000 THEN 0.10
      WHEN ft.price > 50000 AND ft.price <= 100000 THEN 0.15
      WHEN ft.price > 100000 AND ft.price <= 300000 THEN 0.20
      WHEN ft.price > 300000 AND ft.price <= 500000 THEN 0.25
      ELSE 0.30
    END AS persentase_gross_laba,

    --melakukan perhitungan untuk kolom nett sales
    ROUND(ft.price * (1 - ft.discount_percentage),1) AS nett_sales,
    ft.rating AS rating_transaksi

--proses join dengan beberapa table yang dibutuhkan
FROM `kimia_farma.kf_final_transaction_clean` ft 
JOIN `kimia_farma.kf_kantor_cabang_clean` kc ON ft.branch_id=kc.branch_id
JOIN `kimia_farma.kf_product_clean` p ON ft.product_id=p.product_id
)

--menggunakan CTE untuk melakukan perhitungan dalam membuat kolom nett profit
SELECT *, ROUND(nett_sales * persentase_gross_laba,1) AS nett_profit
FROM joined_table;



