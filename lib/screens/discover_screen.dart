import 'package:flutter/material.dart';
import 'package:mini_katalog/screens/basket_screen.dart';
import 'package:mini_katalog/screens/favorite_screen.dart';
import '../models/product.dart';
import 'product_detail_screen.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  String searchQuery = ""; // Arama metnini tutan değişkenimiz
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // Arama kelimesine göre listeyi anlık filtreleyen mantık [cite: 42]
    final filteredProducts = mockProducts
        .where(
          (product) =>
              product.name.toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                favoriteProducts.isNotEmpty
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: favoriteProducts.isNotEmpty
                    ? const Color(0xFFFF6B6B)
                    : const Color(0xFF1A1A1A),
                size: 22,
              ),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavoriteScreen(),
                  ),
                );
                setState(() {});
              },
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 8.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.shopping_basket_outlined,
                      color: Color(0xFF1A1A1A),
                      size: 22,
                    ),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BasketScreen(),
                        ),
                      );
                      setState(() {});
                    },
                  ),
                ),
                if (basketProducts.isNotEmpty)
                  Positioned(
                    right: 0,
                    top: 4,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF6B6B),
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        '${basketProducts.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        // Titremeyi önlemek için SingleChildScrollView + GridView birleşimini ListView yaptık
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          // 1. Başlık Alanı
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: Text(
              'Ürünleri Keşfet',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ),

          // 🔍 2. DÖKÜMANDAKİ ZORUNLU ARAMA ÇUBUĞU (SEARCH BAR) [cite: 42]
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 12.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = searchQuery =
                        value; // Her harf girildiğinde listeyi günceller [cite: 42]
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Ürün ara...',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),

          // 🛍️ 3. DÖKÜMANDAKİ ZORUNLU KAMPANYA BANNER ALANI
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 12.0,
            ),
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              // Dökümanda istenen orijinal banner görsel linki tam olarak buraya geliyor:
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  'https://wantapi.com/assets/banner.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFFE9ECEF),
                      alignment: Alignment.center,
                      child: const Text(
                        'GIFT STORE - %20 İndirim Fırsatı!',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // 📦 4. ZORUNLU GRIDVIEW YAPISI [cite: 46]
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount:
                  filteredProducts.length, // Filtrelenmiş listenin uzunluğu
              itemBuilder: (context, index) {
                final product =
                    filteredProducts[index]; // Burayı filteredProducts olarak düzelttik!
                final isFavorite = favoriteProducts.contains(product);

                return GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailScreen(product: product),
                      ),
                    );
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Stack(
                      children: [
                        // Kart İçeriği
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Ürün Görseli (Burada senin kendi lokal assetlerin basılacak)
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE9ECEF),
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(24),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(24),
                                  ),
                                  // Senin hazırladığın o lokal makyaj görselleri buraya jilet gibi oturuyor:
                                  child: Image.asset(
                                    product.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            // Ürün Bilgileri
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${product.price.toStringAsFixed(2)} TL',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF007AFF),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Sol Üst Kalp Butonu
                        Positioned(
                          left: 8,
                          top: 8,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isFavorite) {
                                  favoriteProducts.remove(product);
                                } else {
                                  favoriteProducts.add(product);
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite
                                    ? const Color(0xFFFF6B6B)
                                    : const Color(0xFF868E96),
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                        // Sağ Alt Ekleme Butonu
                        Positioned(
                          right: 8,
                          bottom: 8,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                basketProducts.add(product);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${product.name} sepete eklendi!',
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  backgroundColor: const Color(0xFF1A1A1A),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Color(0xFFFF6B6B),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
