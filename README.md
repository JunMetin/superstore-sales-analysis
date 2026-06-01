\# Superstore Satış Analizi



SQL ve Power BI kullanılarak 4 yıllık ABD perakende satış verisinin uçtan uca analiz edildiği iş zekası projesi. Kâr getirmeyen ürün kategorileri, indirim stratejisinin kârlılığa etkisi ve bölgesel performans örüntüleri incelenmiştir.



\---



\##  Dashboard



\### Sayfa 1 — Genel Bakış (Overview)

!\[Genel Bakış Dashboard](dashboard/01-overview.jpg)



KPI kartları (toplam satış, kâr, kâr marjı, sipariş sayısı, ortalama sipariş tutarı), aylık trend grafiği ve yıllık büyüme karşılaştırması, eyalet bazlı doldurulmuş harita ile kategori/alt-kategori kırılımı.



\### Sayfa 2 — Ürün ve Kâr Analizi (Product \& Profit Analysis)

!\[Ürün Analizi Dashboard](dashboard/02-product-analysis.jpg)



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



## Klasör Yapısı

```
superstore-sales-analysis/
├── README.md
├── dashboard/
│   ├── superstore-analysis.pbix
│   ├── superstore-analysis.pdf
│   ├── 01-overview.jpg
│   └── 02-product-analysis.jpg
├── sql/
│   ├── 01-basic-aggregations.sql
│   ├── 02-window-functions.sql
│   └── 03-business-insights.sql
├── excel/
│   ├── Superstore-Excel-Analysis.xlsx
│   ├── 04-excel-dashboard.jpg
│   └── 05-excel-pivots.jpg
└── data/
    └── README.md
```



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


---

##  Excel ile Keşifsel Analiz

Aynı veri seti üzerinde Excel ile alternatif analiz sunarak araç çeşitliliğimi gösterdim. Excel projesi 4 sheet'ten oluşuyor:

**1. Raw Data** — Süperstore CSV'sini Power Query (M) ile yüklenmiş, locale tabanlı tip dönüşümü ile düzeltilmiş, `tblSuperstore` adında structured table.

**2. Pivot Analysis** — Üç farklı pivot table:
- Yıllara göre kategori bazlı satış (cross-tab)
- Bölge × Segment kâr matrisi (3-color scale conditional formatting ile heatmap)
- Top 10 müşteri (Top N filter)

**3. Formula Analysis** — Formül beceri sergilenen bölüm:
- `SUMIFS`, `COUNTIFS`, `AVERAGEIFS` ile kategori agregasyonları
- `XLOOKUP` ile dinamik ürün arama aracı (4. parametre olarak "Bulunamadı" fallback)
- `IF` / `IFS` ile kâr durumu sınıflandırması (Yüksek Kâr / Pozitif / Zarar)
- `COUNTIFS` çoklu kriter ile indirim seviyesi analizi

**4. Dashboard** — Interaktif görünüm:
- 4 KPI hücresi (Total Sales, Total Profit, Profit Margin, Unique Orders)
- Aylık satış trendi PivotChart (sezonsallık görünür)
- Kategori dağılımı PivotChart
- Year slicer ile iki chart birden filtrelenir

![Excel Dashboard](excel/04-excel-dashboard.jpg)

![Excel Formula Analysis](excel/05-excel-pivots.jpg)

** Dosya:** [Superstore-Excel-Analysis.xlsx](excel/Superstore-Excel-Analysis.xlsx)


## Hakkımda

**Metin Harmancı**
Yönetim Bilişim Sistemleri 4. Sınıf — Akdeniz Üniversitesi

📧 harmancimetin28@gmail.com
🔗 [LinkedIn](https://www.linkedin.com/in/metin-harmancı-7b15612a8/)
💼 [GitHub](https://github.com/MetinHrmnc)



