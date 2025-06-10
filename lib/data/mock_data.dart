import '../models/product.dart';

class MockData {
  static final List<Product> products = [
    // Pizzalar
    Product(
      id: 'p1',
      name: 'Margarita',
      description: 'Domates sos, mozarella peyniri, fesleğen',
      price: 89.90,
      category: 'Pizzalar',
    ),
    Product(
      id: 'p2',
      name: 'Karışık Pizza',
      description: 'Domates sos, mozarella peyniri, sosis, mantar, biber',
      price: 109.90,
      category: 'Pizzalar',
    ),
    Product(
      id: 'p3',
      name: 'Tavuklu Pizza',
      description: 'Domates sos, mozarella peyniri, tavuk, mısır',
      price: 99.90,
      category: 'Pizzalar',
    ),
    Product(
      id: 'p4',
      name: 'Vejeteryan Pizza',
      description: 'Domates sos, mozarella peyniri, mantar, biber, zeytin',
      price: 94.90,
      category: 'Pizzalar',
    ),

    // Kebaplar
    Product(
      id: 'k1',
      name: 'Adana Kebap',
      description: 'Acılı kıyma, baharatlar',
      price: 129.90,
      category: 'Kebaplar',
    ),
    Product(
      id: 'k2',
      name: 'Urfa Kebap',
      description: 'Acısız kıyma, baharatlar',
      price: 129.90,
      category: 'Kebaplar',
    ),
    Product(
      id: 'k3',
      name: 'Tavuk Şiş',
      description: 'Marine edilmiş tavuk, baharatlar',
      price: 119.90,
      category: 'Kebaplar',
    ),
    Product(
      id: 'k4',
      name: 'Kuzu Şiş',
      description: 'Marine edilmiş kuzu eti, baharatlar',
      price: 139.90,
      category: 'Kebaplar',
    ),

    // İçecekler
    Product(
      id: 'i1',
      name: 'Kola',
      description: '330ml',
      price: 15.90,
      category: 'İçecekler',
    ),
    Product(
      id: 'i2',
      name: 'Ayran',
      description: '300ml',
      price: 12.90,
      category: 'İçecekler',
    ),
    Product(
      id: 'i3',
      name: 'Su',
      description: '500ml',
      price: 8.90,
      category: 'İçecekler',
    ),
    Product(
      id: 'i4',
      name: 'Meyve Suyu',
      description: '330ml',
      price: 14.90,
      category: 'İçecekler',
    ),
  ];

  static List<Map<String, String>> getCategories() {
    return [
      {'name': 'Pizzalar', 'emoji': '🍕'},
      {'name': 'Kebaplar', 'emoji': '🍖'},
      {'name': 'İçecekler', 'emoji': '🥤'},
    ];
  }
}
