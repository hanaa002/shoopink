import 'package:flutter/material.dart';

class AccountItem {
  final String label;
  final IconData icon;

  AccountItem(this.label, this.icon);
}

List<AccountItem> accountItems = [
  AccountItem("Orders", Icons.shopping_bag),
  AccountItem("My Details", Icons.person),
  AccountItem("Notifications", Icons.notifications),
  AccountItem("Help", Icons.help),
  AccountItem("About", Icons.info),
];
