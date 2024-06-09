import 'package:flutter/material.dart';
import 'package:shoopink/models/grocery_item.dart';

class CartProvider with ChangeNotifier {
  List<GroceryItem> _cartItems = [];

  List<GroceryItem> get cartItems => _cartItems;

  void addItem(GroceryItem item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void removeItem(GroceryItem item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  void updateItemQuantity(item, quantity) {
    notifyListeners();
  }
}
