// Import package Flutter
import 'package:flutter/material.dart';
// Import screen yang akan digunakan dalam navigasi
import 'package:shoopink/screens/account/account_screen.dart';
import 'package:shoopink/screens/cart/cart_screen.dart';
import 'package:shoopink/screens/explore_screen.dart';
import 'package:shoopink/screens/home/home_screen.dart';

// Definisikan kelas NavigatorItem
class NavigatorItem {
  // Properti untuk label item navigasi
  final String label;
  // Properti untuk ikon item navigasi
  final IconData icon;
  // Properti untuk indeks item navigasi
  final int index;
  // Properti untuk screen yang terkait dengan item navigasi
  final Widget screen;

  // Konstruktor untuk inisialisasi properti
  NavigatorItem(this.label, this.icon, this.index, this.screen);
}

// Daftar item navigasi
List<NavigatorItem> navigatorItems = [
  // Item navigasi untuk HomeScreen
  NavigatorItem("Shop", Icons.store, 0, HomeScreen()),
  // Item navigasi untuk ExploreScreen
  NavigatorItem("Explore", Icons.search, 1, ExploreScreen()),
  // Item navigasi untuk CartScreen
  NavigatorItem("Cart", Icons.shopping_cart, 2, CartScreen()),
  // Item navigasi untuk AccountScreen
  NavigatorItem("Account", Icons.account_circle, 3, AccountScreen()),
];
