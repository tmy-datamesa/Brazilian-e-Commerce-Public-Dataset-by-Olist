# BigQuery SQL ile Olist E-Ticaret Veri Analizi (Case Study)

Bu proje, Brezilya'nın önde gelen e-ticaret platformu Olist'e ait halka açık veri setini kullanarak **Google BigQuery** üzerinde kapsamlı bir **SQL Vaka Çalışması** (Case Study) sunmaktadır. Proje, veri temizliğinden ileri düzey metrik hesaplamalarına kadar bir veri analizi sürecini baştan sona uygulamayı amaçlamıştır.

## 🎯 Proje Amaçları

BigQuery'nin gücünden yararlanılarak, Olist'in 100K+ sipariş verisi üzerinden aşağıdaki temel hedefler gerçekleştirilmiştir:

* Veri kalitesi kontrolü (NULL ve yinelenen kayıtların tespiti).
* Coğrafi (Şehir/Eyalet) ve metinsel verilerin temizlenmesi ve standartlaştırılması.
* Satış, sipariş, kârlılık ve müşteri davranışları metriklerinin hesaplanması.
* Zaman serisi trendleri ve pazar dinamiklerinin analizi.
* Gerçek iş dünyasına uygulanabilir, aksiyon odaklı içgörüler üretilmesi.

## 🧩 Veri Seti ve Metodoloji

| Kriter | Detay |
| :--- | :--- |
| **Veri Kaynağı** | Brazilian E-Commerce Public Dataset by Olist (Kaggle) |
| **Veri Ambarı** | Google BigQuery (Public Dataset) |
| **Ana Teknoloji** | BigQuery Standard SQL |
| **Ana SQL Dosyası** | `olist.main.query.sql` |

### 🛠️ Kapsamlı Analiz Akışı

Proje, titiz bir veri işleme ve analiz akışını takip etmiştir:

| Bölüm | Konu | Kullanılan Temel SQL Fonksiyonları |
| :--- | :--- | :--- |
| 1️⃣ Veri Kalitesi Kontrolü | NULL ve duplicate analizleri | `COUNT(*), GROUP BY, HAVING` |
| 2️⃣ Veri Temizleme (Cleaning) | Coğrafi verilerde aksan & özel karakter temizliği | `TRANSLATE(), REGEXP_REPLACE()` |
| 3️⃣ Geolocation Standardizasyonu | Şehir ve eyalet adlarının normalize edilmesi | `CREATE OR REPLACE TABLE, WHERE` |
| 5️⃣ Sipariş Analizi | Toplam sipariş, teslimat, iptal, zaman trendi | `DATE_TRUNC(), COUNTIF()` |
| 6️⃣ Gelir ve Kârlılık Analizi | Ciro, AOV, kâr marjı, ödeme tipi dağılımı | `SUM(), ROUND(), GROUP BY` |
| 7️⃣ Satıcı Performansı | Aktif satıcı sayısı, satış hacmi, aktiflik süresi analizi | `DATE_DIFF()` |
| 8️⃣ Müşteri Davranışları | Tekrar alım (sadakat) ve yoğunluk analizi | `COUNTIF(), PARTITION BY` |
| 🔟 Ödeme Analizi | Ödeme yöntemi bazlı ciro, bölgesel kırılımlar | `WINDOW FUNCTIONS` |

---

## 💡 Temel İş İçgörüleri (Key Insights)

Kapsamlı SQL sorgularından elde edilen en kritik iş sonuçları aşağıdadır:

| Metrik | Sonuç | İş Yorumu ve Önerisi |
| :--- | :--- | :--- |
| **Toplam Gelir** | **15.8M BRL** | Brüt satış hacmi, pazar büyüklüğünün temel göstergesidir. |
| **Teslim Edilen Sipariş Oranı** | **%97** | Mükemmel lojistik başarı oranı. Müşteri memnuniyetini olumlu etkiler. |
| **En Yoğun Sipariş Ayı** | **Kasım 2017** | Black Friday döneminin Brezilya e-ticaret pazarındaki dominant etkisini gösterir. Kampanyalar bu döneme yoğunlaştırılmalıdır. |
| **En Çok Sipariş Veren Eyalet** | **SP (São Paulo)** | Pazar yoğunluğunun coğrafi olarak São Paulo'da (Güneydoğu Bölgesi) toplandığını gösterir. |
| **Tekrar Alışveriş Yapan Müşteri Oranı** | **%5.7** | Sadakat oranının düşük olduğunu işaret eder. Müşteri tutma (retention) programlarına yatırım yapılmalıdır. |
| **Ortalama Kâr Marjı** | **%12.4** | Kârlılık marjı düşüktür. Özellikle lojistik maliyetleri ve ürün maliyetleri detaylı incelenmelidir. |
| **En Popüler Kategoriler** | `bed_bath_table`, `health_beauty` | Bu kategorilerde pazar liderliğini korumak için stok ve fiyatlama stratejileri optimize edilmelidir. |
| **En Yaygın Ödeme Tipi** | **Credit Card (%77)** | Kredi kartı entegrasyonu ve güvenliğine öncelik verilmelidir. Taksitli ödeme (installment) seçenekleri genişletilmelidir. |

---
