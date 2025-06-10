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
