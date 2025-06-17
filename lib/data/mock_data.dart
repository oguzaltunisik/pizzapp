import '../models/item.dart';
import '../models/enums.dart';

class MockData {
  static final List<Item> items = [
    // Pizzalar
    Item(
      id: 'p1',
      name: 'Margarita',
      image: '🍕',
      price: 89.90,
      category: Category.pizza,
      toppings: [Toppings.mozzarella, Toppings.tomato, Toppings.mushroom],
    ),
    Item(
      id: 'p2',
      name: 'Karışık Pizza',
      image: '🍕',
      price: 109.90,
      category: Category.pizza,
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
      image: '🍕',
      price: 99.90,
      category: Category.pizza,
      toppings: [Toppings.mozzarella, Toppings.chicken, Toppings.corn],
    ),
    Item(
      id: 'p4',
      name: 'Vejeteryan Pizza',
      image: '🍕',
      price: 94.90,
      category: Category.pizza,
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
      image: '🍖',
      price: 129.90,
      category: Category.kebab,
    ),
    Item(
      id: 'k2',
      name: 'Urfa Kebap',
      image: '🍖',
      description: 'Acısız kıyma, baharatlar',
      price: 129.90,
      category: Category.kebab,
    ),
    Item(
      id: 'k3',
      name: 'Tavuk Şiş',
      image: '🍗',
      description: 'Marine edilmiş tavuk, baharatlar',
      price: 119.90,
      category: Category.kebab,
    ),
    Item(
      id: 'k4',
      name: 'Kuzu Şiş',
      image: '🥩',
      description: 'Marine edilmiş kuzu eti, baharatlar',
      price: 139.90,
      category: Category.kebab,
    ),

    // İçecekler
    Item(
      id: 'i1',
      name: 'Kola',
      image: '🥤',
      description: '330ml',
      price: 15.90,
      category: Category.drink,
    ),
    Item(
      id: 'i2',
      name: 'Ayran',
      image: '🥛',
      description: '300ml',
      price: 12.90,
      category: Category.drink,
    ),
    Item(
      id: 'i3',
      name: 'Su',
      image: '💧',
      description: '500ml',
      price: 8.90,
      category: Category.drink,
    ),
    Item(
      id: 'i4',
      name: 'Meyve Suyu',
      image: '🧃',
      description: '330ml',
      price: 14.90,
      category: Category.drink,
    ),

    // Tatlılar
    Item(
      id: 't1',
      name: 'Künefe',
      image: '🍮',
      description: 'Antep fıstıklı, kaymaklı',
      price: 69.90,
      category: Category.dessert,
    ),
    Item(
      id: 't2',
      name: 'Baklava',
      image: '🧁',
      description: 'Antep fıstıklı, 6 dilim',
      price: 59.90,
      category: Category.dessert,
    ),
    Item(
      id: 't3',
      name: 'Sütlaç',
      image: '🥣',
      price: 39.90,
      category: Category.dessert,
    ),
    Item(
      id: 't4',
      name: 'Kazandibi',
      image: '🍰',
      description: 'Ev yapımı kazandibi',
      price: 39.90,
      category: Category.dessert,
    ),
  ];

  static List<Map<String, String>> getCategories() {
    return [
      {'name': 'Pizzalar', 'emoji': '🍕'},
      {'name': 'Kebaplar', 'emoji': '🍖'},
      {'name': 'İçecekler', 'emoji': '🥤'},
      {'name': 'Tatlılar', 'emoji': '🍰'},
    ];
  }
}
