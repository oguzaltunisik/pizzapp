import '../models/item.dart';
import '../models/enums.dart';

class MockData {
  static final List<Item> items = [
    // Pizzalar
    Item(
      id: 'p1',
      name: 'Margarita',
      description: 'Domates sos, mozarella peyniri, fesleğen',
      price: 89.90,
      category: Category.pizzas,
      toppings: [Toppings.mozzarella, Toppings.tomato, Toppings.mushroom],
    ),
    Item(
      id: 'p2',
      name: 'Karışık Pizza',
      description: 'Domates sos, mozarella peyniri, sosis, mantar, biber',
      price: 109.90,
      category: Category.pizzas,
      toppings: [
        Toppings.mozzarella,
        Toppings.sausage,
        Toppings.mushroom,
        Toppings.greenPepper,
      ],
    ),
    Item(
      id: 'p3',
      name: 'Tavuklu Pizza',
      description: 'Domates sos, mozarella peyniri, tavuk, mısır',
      price: 99.90,
      category: Category.pizzas,
      toppings: [Toppings.mozzarella, Toppings.chicken, Toppings.corn],
    ),
    Item(
      id: 'p4',
      name: 'Vejeteryan Pizza',
      description: 'Domates sos, mozarella peyniri, mantar, biber, zeytin',
      price: 94.90,
      category: Category.pizzas,
      toppings: [
        Toppings.mozzarella,
        Toppings.mushroom,
        Toppings.greenPepper,
        Toppings.blackOlive,
      ],
    ),

    // Kebaplar
    Item(
      id: 'k1',
      name: 'Adana Kebap',
      description: 'Acılı kıyma, baharatlar',
      price: 129.90,
      category: Category.kebabs,
    ),
    Item(
      id: 'k2',
      name: 'Urfa Kebap',
      description: 'Acısız kıyma, baharatlar',
      price: 129.90,
      category: Category.kebabs,
    ),
    Item(
      id: 'k3',
      name: 'Tavuk Şiş',
      description: 'Marine edilmiş tavuk, baharatlar',
      price: 119.90,
      category: Category.kebabs,
    ),
    Item(
      id: 'k4',
      name: 'Kuzu Şiş',
      description: 'Marine edilmiş kuzu eti, baharatlar',
      price: 139.90,
      category: Category.kebabs,
    ),

    // İçecekler
    Item(
      id: 'i1',
      name: 'Kola',
      description: '330ml',
      price: 15.90,
      category: Category.drinks,
    ),
    Item(
      id: 'i2',
      name: 'Ayran',
      description: '300ml',
      price: 12.90,
      category: Category.drinks,
    ),
    Item(
      id: 'i3',
      name: 'Su',
      description: '500ml',
      price: 8.90,
      category: Category.drinks,
    ),
    Item(
      id: 'i4',
      name: 'Meyve Suyu',
      description: '330ml',
      price: 14.90,
      category: Category.drinks,
    ),

    // Tatlılar
    Item(
      id: 't1',
      name: 'Künefe',
      description: 'Antep fıstıklı, kaymaklı',
      price: 69.90,
      category: Category.desserts,
    ),
    Item(
      id: 't2',
      name: 'Baklava',
      description: 'Antep fıstıklı, 6 dilim',
      price: 59.90,
      category: Category.desserts,
    ),
    Item(
      id: 't3',
      name: 'Sütlaç',
      description: 'Fırında sütlaç',
      price: 39.90,
      category: Category.desserts,
    ),
    Item(
      id: 't4',
      name: 'Kazandibi',
      description: 'Ev yapımı kazandibi',
      price: 39.90,
      category: Category.desserts,
    ),
  ];

  static List<Map<String, String>> getCategories() {
    return Category.values
        .map((category) => {'name': category.name, 'emoji': category.emoji})
        .toList();
  }
}
