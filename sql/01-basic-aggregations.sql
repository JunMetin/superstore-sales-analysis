--Soru 1:Kategorilere göre toplam satýþ, toplam kâr ve kâr marjý yüzdesini getir. Kâr marjýna göre azalan þeklinde sýralayan sorgu

SELECT 
    "Category", 
    SUM("Sales") AS toplam_satis, 
    SUM("Profit") AS toplam_kar, 
    ROUND((SUM("Profit") / SUM("Sales")) * 100, 2) AS kar_marji 
FROM superstore_orders 
GROUP BY "Category" 
ORDER BY kar_marji;

--soru 2:Her eyalette kaç farklý müþteri sipariþ vermiþ ve toplam satýþ nedir? Sadece 10'dan fazla farklý müþterisi olan eyaletleri göster, müþteri sayýsýna göre azalan þeklinde sýralayan sorgu

SELECT 
    "State",
    COUNT(DISTINCT "Customer ID") AS musteri_sayi,
    SUM("Sales") AS toplam_satis
FROM superstore_orders 
GROUP BY "State" 
HAVING COUNT(DISTINCT "Customer ID") > 10 
ORDER BY musteri_sayi;

