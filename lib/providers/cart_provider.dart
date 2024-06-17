import 'package:flutter/material.dart';
import 'package:shoopink/models/grocery_item.dart';

class CartProvider with ChangeNotifier {
  List<GroceryItem> _cartItems = []; // List untuk menyimpan item-item yang ada di keranjang

  List<GroceryItem> get cartItems => _cartItems; // Getter untuk mendapatkan daftar item di keranjang

  // Method untuk menambahkan item ke keranjang
  void addItem(GroceryItem item) {
    _cartItems.add(item);
    notifyListeners(); // Memanggil notifyListeners untuk memberitahu listener bahwa ada perubahan
  }

  // Method untuk menghapus item dari keranjang
  void removeItem(GroceryItem item) {
    _cartItems.remove(item);
    notifyListeners(); // Memanggil notifyListeners untuk memberitahu listener bahwa ada perubahan
  }

  // Method untuk mengupdate jumlah barang dari sebuah item di keranjang
  void updateItemQuantity(GroceryItem item, int quantity) {
    item.amount = quantity; // Mengupdate jumlah barang dari item yang dipilih
    notifyListeners(); // Memanggil notifyListeners untuk memberitahu listener bahwa ada perubahan
  }

  // Method untuk mengosongkan keranjang belanja
  void clearCart() {
    _cartItems.clear(); // Menghapus semua item dari keranjang
    notifyListeners(); // Memanggil notifyListeners untuk memberitahu listener bahwa ada perubahan
  }
}
