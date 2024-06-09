import 'package:flutter/material.dart';
import 'package:shoopink/screens/account/account_screen.dart';
import 'package:shoopink/screens/cart/cart_screen.dart';
import 'package:shoopink/screens/explore_screen.dart';
import 'package:shoopink/screens/home/home_screen.dart';

class NavigatorItem {
  final String label;
  final IconData icon;
  final int index;
  final Widget screen;

  NavigatorItem(this.label, this.icon, this.index, this.screen);
}

List<NavigatorItem> navigatorItems = [
  NavigatorItem("Shop", Icons.store, 0, HomeScreen()),
  NavigatorItem("Explore", Icons.search, 1, ExploreScreen()),
  NavigatorItem("Cart", Icons.shopping_cart, 2, CartScreen()),
  NavigatorItem("Account", Icons.account_circle, 3, AccountScreen()),
];
