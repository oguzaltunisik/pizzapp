class Customer {
  final String name;
  final String phone;
  final String? address;

  Customer({required this.name, required this.phone, this.address});

  Map<String, dynamic> toJson() => {
    'name': name,
    'phone': phone,
    'address': address,
  };

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    name: json['name'],
    phone: json['phone'],
    address: json['address'],
  );
}
