# Brazilian E-Commerce Public Dataset by Olist  
**Data Masası | BigQuery SQL Case Study**

Bu proje, **Kaggle Olist veri seti** üzerinden veri temizliği, dönüşüm ve analiz adımlarını kapsayan bir **BigQuery SQL** çalışmasıdır.  
Olist’in e-ticaret platformuna ait 100k+ sipariş, müşteri, satıcı ve ürün bilgisinden iş içgörüleri üretilmiştir.

---

## 🎯 Proje Amacı
Olist verilerini kullanarak:
- Veri kalitesi kontrolleri (NULL, duplicate, anormallik tespiti)
- Coğrafi, müşteri ve satıcı şehir isimlerinin temizlenmesi
- Sipariş, satış, ürün ve müşteri metriklerinin analizi
- Zaman serisi trendleri, AOV, CLV ve kârlılık hesapları
- Gerçek dünyada uygulanabilir iş içgörülerinin çıkarılması

---

## 🧩 Veri Seti Kaynağı
- **Kaggle:** [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce/data)
- **Platform:** Google BigQuery (Public Dataset)
- **Ana SQL dosyası:** [`olist.main.query.sql`](https://github.com/tmy-datamesa/Brazilian-ECommerce-Public-Dataset-by-Olist/blob/main/olist.main.query.sql)

---

## 📚 İçerik Özeti

| Bölüm | Konu | Açıklama |
|:------|:------|:----------|
| **1️⃣ Veri Kalitesi Kontrolü** | NULL ve duplicate analizleri | Her tablo için eksik/veri tekrar kontrolleri |
| **2️⃣ Veri Temizleme (Cleaning)** | City sütunlarında aksan & özel karakter temizliği | `TRANSLATE()`, `REGEXP_REPLACE()` |
| **3️⃣ Geolocation Standardizasyonu** | Şehir ve eyalet adlarının normalize edilmesi | `CREATE OR REPLACE TABLE ...` |
| **4️⃣ Seller & Customer Temizliği** | `seller_city`, `customer_city` düzeltmeleri | Aksan, özel karakter, gereksiz boşluklar |
| **5️⃣ Sipariş Analizi (Orders)** | Toplam sipariş, teslimat, iptal, zaman trendi | Günlük, aylık, çeyreklik trendler |
| **6️⃣ Gelir ve Kârlılık Analizi** | Ciro, AOV, kâr marjı, ödeme tipi | `SUM()`, `ROUND()`, `GROUP BY` |
| **7️⃣ Satıcı Performansı** | Aktif satıcı sayısı, satış hacmi, süre analizi | `DATE_DIFF()` ile aktiflik ölçümü |
| **8️⃣ Müşteri Davranışları** | Tekrar alım, sadakat, yoğunluk analizi | `COUNTIF()`, `PARTITION BY` |
| **9️⃣ Ürün Analizi** | Popüler kategoriler, yıllık trend, rating etkisi | Kategori bazında `JOIN` ve `GROUP BY` |
| **🔟 Ödeme Analizi** | Yöntem bazlı ciro, eyalet & kategori kırılımı | `WINDOW FUNCTIONS`, yüzde dağılım hesapları |

---

## 💡 Elde Edilen İş İçgörüleri

- **Toplam gelir:** 15.8M BRL  
- **Teslim edilen sipariş oranı:** %97  
- **En yoğun sipariş ayı:** Kasım 2017  
- **En çok sipariş veren eyalet:** SP (São Paulo)  
- **En popüler kategoriler:** bed_bath_table, health_beauty, sports_leisure  
- **Tekrar alışveriş yapan müşteri oranı:** %5.7  
- **Ortalama kâr marjı:** %12.4  
- **En yaygın ödeme tipi:** Credit Card (%77)  

---




