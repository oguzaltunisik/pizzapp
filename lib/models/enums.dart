enum DeliveryMethod {
  pickup('Restorandan Alım'),
  delivery('Adrese Teslimat');

  final String label;
  const DeliveryMethod(this.label);
}

enum PaymentMethod {
  cash('Nakit'),
  creditCard('Kredi Kartı');

  final String label;
  const PaymentMethod(this.label);
}

enum OrderStatus {
  pending('Hazırlanıyor'),
  preparing('Hazırlanıyor'),
  ready('Hazır'),
  onTheWay('Yolda'),
  delivered('Teslim Edildi'),
  cancelled('İptal Edildi');

  final String label;
  const OrderStatus(this.label);
}

enum Toppings {
  mozzarella('Mozzarella Peyniri', 2.0),
  cheddar('Cheddar Peyniri', 2.5),
  pepperoni('Pepperoni', 3.0),
  sausage('Sosis', 2.5),
  mushroom('Mantar', 1.5),
  greenPepper('Yeşil Biber', 1.0),
  onion('Soğan', 1.0),
  corn('Mısır', 1.5),
  blackOlive('Siyah Zeytin', 2.0),
  pineapple('Ananas', 2.5),
  tomato('Domates', 1.0),
  beef('Sığır Eti', 4.0),
  chicken('Tavuk', 3.5),
  pastrami('Pastırma', 4.5),
  sujuk('Sucuk', 3.0);

  final String label;
  final double price;
  const Toppings(this.label, this.price);
}

enum Category {
  pizza('Pizzalar'),
  kebab('Kebaplar'),
  drink('İçecekler'),
  dessert('Tatlılar');

  final String label;
  const Category(this.label);
}
