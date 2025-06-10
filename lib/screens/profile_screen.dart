import 'package:flutter/material.dart';
import 'orders_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profilim')),
      body: ListView(
        children: [
          const ListTile(
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Text('Kullanıcı Adı'),
            subtitle: Text('kullanici@email.com'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.receipt_long),
            title: const Text('Siparişlerim'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const OrdersScreen()),
              );
            },
          ),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text('Ayarlar'),
            trailing: Icon(Icons.chevron_right),
          ),
          const ListTile(
            leading: Icon(Icons.help),
            title: Text('Yardım'),
            trailing: Icon(Icons.chevron_right),
          ),
          const ListTile(leading: Icon(Icons.logout), title: Text('Çıkış Yap')),
        ],
      ),
    );
  }
}
