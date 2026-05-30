--Soru 1: Her müþterinin sipariþlerini kronolojik sýrayla listele. Yanýna o müþterinin kümülatif toplam harcamasýný ekle. Müþteri adý, sipariþ tarihi, sipariþ tutarý ve kümülatif toplam görünen sorgu

select "Customer Name","Order Date",sum("Sales") as toplam_satis,sum(sum("Sales")) over(partition by "Customer Name" order by "Order Date") as kumulatif_toplam from superstore_orders group by "Customer Name", "Order Date" order by "Customer Name", "Order Date" asc


--Soru 2: Her segment için (Consumer, Corporate, Home Office): toplam satýþ, toplam kâr, farklý sipariþ sayýsý ve her segmentin toplam satýþ içindeki yüzde payýný gösteren sorgu

select "Segment",sum("Sales") as toplam_satis,sum("Profit") as toplam_kar,count(distinct "Order ID") as farkli_satis,round(sum("Sales")/sum(sum("Sales")) over()*100,2)||'%' as yuzde_pay from superstore_orders group by "Segment"