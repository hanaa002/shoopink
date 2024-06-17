// Import package Flutter untuk menggunakan widget dan ikon
import 'package:flutter/material.dart';

// Mendefinisikan class AccountItem
class AccountItem {
  // Deklarasi variabel final label untuk menyimpan teks label
  final String label;
  // Deklarasi variabel final icon untuk menyimpan ikon
  final IconData icon;

  // Constructor untuk AccountItem yang menerima label dan icon sebagai parameter
  AccountItem(this.label, this.icon);
}

// Membuat list AccountItem dengan nama accountItems
List<AccountItem> accountItems = [
  // Menambahkan item "Orders" dengan ikon shopping_bag ke dalam list
  AccountItem("Orders", Icons.shopping_bag),
  // Menambahkan item "My Details" dengan ikon person ke dalam list
  AccountItem("My Details", Icons.person),
  // Menambahkan item "Notifications" dengan ikon notifications ke dalam list
  AccountItem("Notifications", Icons.notifications),
  // Menambahkan item "Help" dengan ikon help ke dalam list
  AccountItem("Help", Icons.help),
  // Menambahkan item "About" dengan ikon info ke dalam list
  AccountItem("About", Icons.info),
];
