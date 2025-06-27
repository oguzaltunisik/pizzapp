import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/orders_provider.dart';
import '../models/enums.dart';
import '../models/customer.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  DeliveryMethod _deliveryMethod = DeliveryMethod.pickup;
  PaymentMethod _paymentMethod = PaymentMethod.cash;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _submitOrder() {
    if (!_formKey.currentState!.validate()) return;

    final cart = Provider.of<CartProvider>(context, listen: false);
    final orders = Provider.of<OrdersProvider>(context, listen: false);

    final customer = Customer(
      name: _nameController.text,
      phone: _phoneController.text,
      address: _deliveryMethod == DeliveryMethod.delivery
          ? _addressController.text
          : null,
    );

    orders.addOrder(
      cart.items.values.toList(),
      cart.totalAmount,
      customer: customer,
      deliveryMethod: _deliveryMethod,
      paymentMethod: _paymentMethod,
    );
    cart.clear();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Siparişiniz alındı!')));

    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ödeme')),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return const Center(child: Text('Sepetiniz boş'));
          }

          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Teslimat Bilgileri',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Ad Soyad',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen adınızı girin';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Telefon',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen telefon numaranızı girin';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                const Text(
                  'Teslimat Yöntemi',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Card(
                  child: Column(
                    children: [
                      RadioListTile<DeliveryMethod>(
                        title: Text(DeliveryMethod.pickup.label),
                        value: DeliveryMethod.pickup,
                        groupValue: _deliveryMethod,
                        onChanged: (value) {
                          setState(() {
                            _deliveryMethod = value!;
                          });
                        },
                      ),
                      RadioListTile<DeliveryMethod>(
                        title: Text(DeliveryMethod.delivery.label),
                        value: DeliveryMethod.delivery,
                        groupValue: _deliveryMethod,
                        onChanged: (value) {
                          setState(() {
                            _deliveryMethod = value!;
                          });
                        },
                      ),
                      if (_deliveryMethod == DeliveryMethod.delivery) ...[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextFormField(
                            controller: _addressController,
                            decoration: const InputDecoration(
                              labelText: 'Adres',
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 3,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Lütfen adresinizi girin';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Ödeme Yöntemi',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Card(
                  child: Column(
                    children: [
                      RadioListTile<PaymentMethod>(
                        title: Text(PaymentMethod.cash.label),
                        value: PaymentMethod.cash,
                        groupValue: _paymentMethod,
                        onChanged: (value) {
                          setState(() {
                            _paymentMethod = value!;
                          });
                        },
                      ),
                      RadioListTile<PaymentMethod>(
                        title: Text(PaymentMethod.creditCard.label),
                        value: PaymentMethod.creditCard,
                        groupValue: _paymentMethod,
                        onChanged: (value) {
                          setState(() {
                            _paymentMethod = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100), // Bottom bar için boşluk
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) return const SizedBox();
          return ElevatedButton.icon(
            label: Text(
              'Siparişi Ver: ${cart.totalAmount.toStringAsFixed(2)}₺',
            ),
            icon: Icon(Icons.check),
            onPressed: _submitOrder,
          );
        },
      ),
    );
  }
}
