\# Superstore Satış Analizi



SQL ve Power BI kullanılarak 4 yıllık ABD perakende satış verisinin uçtan uca analiz edildiği iş zekası projesi. Kâr getirmeyen ürün kategorileri, indirim stratejisinin kârlılığa etkisi ve bölgesel performans örüntüleri incelenmiştir.



\---



\##  Dashboard



\### Sayfa 1 — Genel Bakış (Overview)

!\[Genel Bakış Dashboard](dashboard/01-overview.png)



KPI kartları (toplam satış, kâr, kâr marjı, sipariş sayısı, ortalama sipariş tutarı), aylık trend grafiği ve yıllık büyüme karşılaştırması, eyalet bazlı doldurulmuş harita ile kategori/alt-kategori kırılımı.



\### Sayfa 2 — Ürün ve Kâr Analizi (Product \& Profit Analysis)

!\[Ürün Analizi Dashboard](dashboard/02-product-analysis.png)



Sub-category bazlı scatter plot (satış vs kâr), kâr marjı koşullu biçimlendirmeli Top 5 ürün tablosu, hiyerarşik treemap ve indirim seviyesi etki analizi.



\---



\##  Önemli Bulgular



1\. \*\*Furniture alt kategorileri genel kârı düşürüyor.\*\* Tables ve Bookcases tutarlı satışlar yapmasına rağmen net zararla çalışıyor — fiyatlama ve indirim politikasının gözden geçirilmesi gerekiyor.



2\. \*\*İndirim eşiği %30.\*\* Ortalama kâr, indirimsiz \*\*$0.32M\*\*'den %30+ indirimli \*\*-$0.14M\*\*'ye düşüyor. Öneri: maksimum indirim oranı %15-20 ile sınırlandırılmalı.



3\. \*\*En çok satan ≠ en kârlı.\*\* Cisco TelePresence satışa göre Top 5'te yer almasına rağmen \*\*-%8 kâr marjıyla\*\* çalışıyor — yüksek ciro, alttaki zararı gizliyor.



4\. \*\*Coğrafi yoğunlaşma.\*\* California ve New York satışların büyük kısmını oluştururken birkaç Central ve Southern eyalet 4 yıl boyunca düşük performans gösteriyor.



\---



\##  Kullanılan Araçlar



| Katman              | Araç                              |

|---------------------|-----------------------------------|

| Veri Depolama       | PostgreSQL (Supabase)             |

| Veri Sorgulama      | SQL — CTE, window functions       |

| Veri Modelleme      | Power BI (star schema, Date Dim)  |

| Veri Dönüştürme     | Power Query (M)                   |

| Hesaplamalar        | DAX (time intelligence, measures) |

| Görselleştirme      | Power BI Desktop                  |



\---



\##  Klasör Yapısı



superstore-sales-analysis/

├── README.md

├── dashboard/

│   ├── superstore-analysis.pbix      # Power BI dosyası

│   ├── superstore-analysis.pdf       # Statik PDF export

│   ├── 01-overview.jpg               # Sayfa 1 ekran görüntüsü

│   └── 02-product-analysis.jpg       # Sayfa 2 ekran görüntüsü

├── sql/

│   ├── 01-basic-aggregations.sql     # GROUP BY, HAVING, DISTINCT

│   ├── 02-window-functions.sql       # DENSE\_RANK, LAG, running totals

│   └── 03-business-insights.sql      # Çok adımlı CTE'lerle iş analizleri

└── data/

└── README.md                     # Veri seti kaynak linki





\---



\##  Veri Seti



\- \*\*Kaynak:\*\* \[Superstore Dataset on Kaggle](https://www.kaggle.com/datasets/vivek468/superstore-dataset-final/data)

\- \*\*Kayıt sayısı:\*\* 9.994 işlem

\- \*\*Dönem:\*\* Ocak 2014 – Aralık 2017

\- \*\*Kapsam:\*\* 3 kategori, 17 alt-kategori, 1.800+ ürün, 49 ABD eyaleti



\---



\##  SQL Öne Çıkanlar



`/sql` klasörü, karmaşıklık seviyesine göre gruplanmış sorgular içerir:



\- \*\*`01-basic-aggregations.sql`\*\* — Kategori kârlılığı, `HAVING COUNT(DISTINCT)` ile eyalet bazında müşteri yoğunluğu

\- \*\*`02-window-functions.sql`\*\* — `DENSE\\\_RANK() OVER (PARTITION BY ...)` ile grup içi top-N, `LAG()` ve `NULLIF()` ile güvenli yüzde değişim

\- \*\*`03-business-insights.sql`\*\* — Running total ile müşteri kümülatif harcaması, iç içe agregalarla (`SUM(SUM(...)) OVER()`) segment bazlı yüzde pay



Her dosyada iş sorusu ve kullanılan SQL pattern'i yorum satırlarıyla açıklanmıştır.



\---



\##  Nasıl Görüntülenir



\*\*Seçenek 1: İnteraktif (.pbix)\*\*

1\. `dashboard/superstore-analysis.pbix` dosyasını indir

2\. \[Power BI Desktop](https://www.microsoft.com/en-us/download/details.aspx?id=58494) (ücretsiz) ile aç

3\. Slicer, drill-through ve tooltip'lerle etkileşime gir



\*\*Seçenek 2: Statik (.pdf)\*\*

\- Kurulum gerekmeden görmek için `dashboard/superstore-analysis.pdf` dosyasını aç



\---



\##  Hakkımda



\*\*\[Metin Harmancı]\*\*

Yönetim Bilişim Sistemleri 4.sınıf Akdeniz üniversitesi



&#x20;\[harmancimetin28@gmail.com]

&#x20;\[https://www.linkedin.com/in/metin-harmanc%C4%B1-7b15612a8/]



