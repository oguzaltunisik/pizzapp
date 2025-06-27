import '../models/item.dart';
import '../models/enums.dart';

class MockData {
  static final List<Item> items = [
    // Pizzalar
    Item(
      id: 'p1',
      name: 'Margarita',
      image: '🍕',
      price: 3.90,
      category: Category.pizza,
      toppings: [Toppings.mozzarella, Toppings.tomato, Toppings.mushroom],
    ),
    Item(
      id: 'p2',
      name: 'Karışık Pizza',
      image: '🍕',
      price: 6.90,
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
      price: 9.90,
      category: Category.pizza,
      toppings: [Toppings.mozzarella, Toppings.chicken, Toppings.corn],
    ),
    Item(
      id: 'p4',
      name: 'Vejeteryan Pizza',
      image: '🍕',
      price: 4.90,
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
      price: 12.90,
      category: Category.kebab,
    ),
    Item(
      id: 'k2',
      name: 'Urfa Kebap',
      image: '🍖',
      description: 'Acısız kıyma, baharatlar',
      price: 12.90,
      category: Category.kebab,
    ),
    Item(
      id: 'k3',
      name: 'Tavuk Şiş',
      image: '🍗',
      description: 'Marine edilmiş tavuk, baharatlar',
      price: 14.90,
      category: Category.kebab,
    ),
    Item(
      id: 'k4',
      name: 'Kuzu Şiş',
      image: '🥩',
      description: 'Marine edilmiş kuzu eti, baharatlar',
      price: 13.90,
      category: Category.kebab,
    ),

    // İçecekler
    Item(
      id: 'i1',
      name: 'Kola',
      image: '🥤',
      description: '330ml',
      price: 2.90,
      category: Category.drink,
    ),
    Item(
      id: 'i2',
      name: 'Ayran',
      image: '🥛',
      description: '300ml',
      price: 1.90,
      category: Category.drink,
    ),
    Item(
      id: 'i3',
      name: 'Su',
      image: '💧',
      description: '500ml',
      price: 0.20,
      category: Category.drink,
    ),
    Item(
      id: 'i4',
      name: 'Meyve Suyu',
      image: '🧃',
      description: '330ml',
      price: 1.90,
      category: Category.drink,
    ),

    // Tatlılar
    Item(
      id: 't1',
      name: 'Künefe',
      image: '🍮',
      description: 'Antep fıstıklı, kaymaklı',
      price: 6.90,
      category: Category.dessert,
    ),
    Item(
      id: 't2',
      name: 'Baklava',
      image: '🧁',
      description: 'Antep fıstıklı, 6 dilim',
      price: 3.90,
      category: Category.dessert,
    ),
    Item(
      id: 't3',
      name: 'Sütlaç',
      image: '🥣',
      price: 3.90,
      category: Category.dessert,
    ),
    Item(
      id: 't4',
      name: 'Kazandibi',
      image: '🍰',
      description: 'Ev yapımı kazandibi',
      price: 3.90,
      category: Category.dessert,
    ),
    Item(
      id: 't5',
      name: 'Tiramisu',
      image: '🍰',
      description: 'İtalyan usulü, kahveli',
      price: 8.90,
      category: Category.dessert,
    ),
    Item(
      id: 't6',
      name: 'Cheesecake',
      image: '🧀',
      description: 'New York usulü, çilek soslu',
      price: 7.90,
      category: Category.dessert,
    ),
    Item(
      id: 't7',
      name: 'Brownie',
      image: '🍫',
      description: 'Çikolatalı, fındıklı',
      price: 5.90,
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
