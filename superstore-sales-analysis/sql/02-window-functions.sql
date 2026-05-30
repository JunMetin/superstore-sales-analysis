--Soru 1: Her kategoride satýþa göre en iyi 3 sub-category'yi listele. Kategori adý, sub-category adý ve toplam satýþý gösteren sorgu

WITH musteri AS (
  SELECT "Category", "Sub-Category", "Sales" 
  FROM superstore_orders
),
BestC AS (
  SELECT 
    "Category",
    "Sub-Category",
    SUM("Sales") AS toplam_satis,
    DENSE_RANK() OVER(PARTITION BY "Category" ORDER BY SUM("Sales") DESC) AS EnCategory 
  FROM musteri
  GROUP BY "Category", "Sub-Category"
)
SELECT 
  EnCategory,
  "Category",
  "Sub-Category",
  toplam_satis 
FROM BestC 
WHERE EnCategory <= 3 
ORDER BY "Category", EnCategory;

--Soru 2: Aylýk toplam satýþlarý hesapla. Her ay için: önceki ayýn satýþý ve bir önceki aya göre yüzde deðiþimi göster. Kronolojik sýralayan sorgu

select sum("Sales") as toplam_satis, DATE_TRUNC('month',"Order Date") as ay, LAG(sum("Sales")) over(order by DATE_TRUNC('month',"Order Date" )) as onceki_ay, ROUND(
        (SUM("Sales") - LAG(SUM("Sales")) OVER(ORDER BY DATE_TRUNC('month', "Order Date"))) 
        / NULLIF(LAG(SUM("Sales")) OVER(ORDER BY DATE_TRUNC('month', "Order Date")), 0) * 100
    , 2) || '%' AS aylik_satis_farki from superstore_orders group by DATE_TRUNC('month',"Order Date") order by DATE_TRUNC('month',"Order Date") asc

