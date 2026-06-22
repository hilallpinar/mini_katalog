class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  // Dökümandaki "fromJson temel mantığı" için eklenen kurumsal fabrika metodu
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
    );
  }
}

// Sepetteki ve favorideki ürünleri tutacağımız global listeler
final List<Product> basketProducts = [];
final List<Product> favoriteProducts = [];

// Yepyeni Premium Kozmetik & Makyaj Ürün Listesi (Yerel Assets Bağlantılı)
final List<Product> mockProducts = [
  Product(
    id: '1',
    name: 'Mat Dudak Ruj Seti',
    description:
        'Yoğun renk pigmentasyonu, gün boyu kalıcı mat formül ve dudağı kurutmayan kadifemsi dokunuş.',
    price: 850.00,
    imageUrl: 'assets/matruj.jpg',
  ),
  Product(
    id: '2',
    name: 'Işıltılı Aydınlatıcı Paleti',
    description:
        'Yüz hatlarınızı ön plana çıkaran, ipeksi dokuya sahip 4 farklı metalik ve sedefli renk seçeneği.',
    price: 1250.00,
    imageUrl: 'assets/aydınlatıcı.jpeg',
  ),
  Product(
    id: '3',
    name: 'Göz Farı Paleti (Nude Tonlar)',
    description:
        'Gündüzden geceye her makyaja uyum sağlayan, kolayca dağılan mat ve ışıltılı toprak tonları bir arada.',
    price: 1450.00,
    imageUrl: 'assets/farpaleti.jpg',
  ),
  Product(
    id: '4',
    name: 'Nemlendirici Likit Fondöten',
    description:
        '24 saat nemlendirme etkili, SPF 20 korumalı, cilt tonunu eşitleyen ve doğal bitiş sunan hafif formül.',
    price: 1850.00,
    imageUrl: 'assets/fondoten.jpeg',
  ),
  Product(
    id: '5',
    name: 'Hacim Veren Maskara',
    description:
        'Özel tasarım silikon fırçasıyla kirpikleri tek tek ayıran, ekstra siyah ve yoğun hacim veren formül.',
    price: 620.00,
    imageUrl: 'assets/maskara.jpg.avif',
  ),
  Product(
    id: '6',
    name: 'Profesyonel Makyaj Fırça Seti',
    description:
        'Yüz, göz ve dudak makyajı için üretilmiş, dökülme yapmayan ultra yumuşak sentetik kıllardan oluşan 8\'li set.',
    price: 980.00,
    imageUrl: 'assets/fırcaseti.jpeg',
  ),
];
