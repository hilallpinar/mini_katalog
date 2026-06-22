# Mini Katalog Uygulaması - Flutter Ödevi

Bu projeyi, Flutter Günlük Eğitim Programı kapsamında dökümanda belirtilen tüm isterlere ve tasarım kurallarına uyumlu olarak geliştirdim. Temel mobil uygulama geliştirme mantığını, sayfa geçişlerini ve durum yönetimini (state) uyguladığım bir taslak çalışmadır.

## ✨ Uygulamada Neler Yaptım?

- **Ürünleri Keşfet (Ana Sayfa):** Tasarımı dökümandaki gibi yan yana ikişerli kart düzeninde (`GridView.builder`) listeledim. Sayfa geçişlerinde veya kaydırırken oluşan kasma ve titreme sorunlarını özel liste motoru mimarisiyle tamamen çözdüm.
- **GIFT STORE Kampanya Alanı:** Dökümanda zorunlu tutulan indirim banner alanını arayüze şık bir şekilde entegre ettim.
- **Dinamik Arama Çubuğu (Search Bar):** Kullanıcının yazdığı kelimeye göre ürün listesini anlık olarak filtreleyen arama motorunu dökümandaki plana sadık kalarak yazdım.
- **Detay Sayfası:** Keşfet ekranından, sepetten veya favorilerden bir ürüne tıklandığında, o ürüne ait bilgileri güvenli bir şekilde (`Navigator.push`) detay sayfasına taşıdım ve gösterdim.
- **Sepet & Favori Sistemi (Simülasyon):** `StatefulWidget` ve `setState` mantığını kullanarak sepete/favorilere ürün ekleme, çıkarma ve sepet ekranında dinamik olarak toplam fiyat hesaplama özelliklerini ekledim.
- **Veri Modeli & Uzantılar:** Kod standartlarına uymak adına `Product` model sınıfımın içine `fromJson` metodunu yazdım. Uygulamada internet kopmalarına karşı tüm kozmetik ürün görsellerini yerel asset (`assets/`) olarak projeye gömdüm ve dosya uzantılarını bilgisayarımdaki isimlerle birebir eşitledim.

## 🛠️ Kullanan Teknolojiler & Sürümler
- **Framework:** Flutter SDK
- **Dil:** Dart
- **UI Kütüphanesi:** material.dart (Eğitim kuralları gereği ekstra hiçbir üçüncü parti paket kullanılmamıştır.)

## 📦 Projeyi Bilgisayarınızda Çalıştırma Adımları

1. Bu repoyu bilgisayarınıza klonlayın:
   
   git clone <buraya_kendi_github_linkini_yaz>

   Proje klasörünün içine girin:
    cd mini_katalog

    Paketleri ve yerel görselleri yüklemek için şu komutu çalıştırın:
    flutter pub get

    Uygulamayı emülatörde veya cihazınızda başlatın:
    flutter run