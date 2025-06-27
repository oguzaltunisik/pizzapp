import 'package:flutter/material.dart';
import 'package:pizzapp/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'providers/orders_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
        ChangeNotifierProvider(create: (ctx) => OrdersProvider()),
      ],
      child: MaterialApp(
        title: 'PizzApp',
        theme: ThemeData(
          primarySwatch: Colors.red,
          useMaterial3: true,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size.fromHeight(36),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              elevation: 0,
            ),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
