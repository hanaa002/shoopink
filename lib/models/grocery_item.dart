import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GroceryItem {
  final int? id;
  final String name;
  final String description;
  final double price;
  final String imagePath;
  int amount;

  GroceryItem({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    this.amount = 1,
  });
}

String formatPrice(double price) {
  final formatter = NumberFormat.simpleCurrency(
      locale: 'id_ID', name: 'Rp', decimalDigits: 0);
  return formatter.format(price);
}

var demoItems = [
  GroceryItem(
      id: 1,
      name: "Pisang",
      description: "7pcs",
      price: 34000.0,
      imagePath: "assets/images/grocery_images/banana.png"),
  GroceryItem(
      id: 2,
      name: "Apel",
      description: "1kg",
      price: 21000.0,
      imagePath: "assets/images/grocery_images/apple.png"),
  GroceryItem(
      id: 3,
      name: "Paprika",
      description: "1kg",
      price: 65000.0,
      imagePath: "assets/images/grocery_images/pepper.png"),
  GroceryItem(
      id: 4,
      name: "Jahe",
      description: "250gr",
      price: 18000.0,
      imagePath: "assets/images/grocery_images/ginger.png"),
  GroceryItem(
      id: 5,
      name: "Daging",
      description: "250gr",
      price: 41000.0,
      imagePath: "assets/images/grocery_images/beef.png"),
  GroceryItem(
      id: 6,
      name: "Ayam",
      description: "250gr",
      price: 29000.0,
      imagePath: "assets/images/grocery_images/chicken.png"),
];

var exclusiveOffers = [demoItems[0], demoItems[1]];
var bestSelling = [demoItems[2], demoItems[3]];
var groceries = [demoItems[4], demoItems[5]];

var beverages = [
  GroceryItem(
      id: 7,
      name: "Diet Coke",
      description: "355ml",
      price: 18000.0,
      imagePath: "assets/images/beverages_images/diet_coke.png"),
  GroceryItem(
      id: 8,
      name: "Sprite",
      description: "325ml",
      price: 17000.0,
      imagePath: "assets/images/beverages_images/sprite.png"),
  GroceryItem(
      id: 9,
      name: "Jus Apel",
      description: "2L",
      price: 38000.0,
      imagePath: "assets/images/beverages_images/apple_and_grape_juice.png"),
  GroceryItem(
      id: 10,
      name: "Jus Jeruk",
      description: "2L",
      price: 45000.0,
      imagePath: "assets/images/beverages_images/orange_juice.png"),
  GroceryItem(
      id: 11,
      name: "Coca Cola",
      description: "325ml",
      price: 22000.0,
      imagePath: "assets/images/beverages_images/coca_cola.png"),
  GroceryItem(
      id: 12,
      name: "Pepsi",
      description: "330ml",
      price: 39000.0,
      imagePath: "assets/images/beverages_images/pepsi.png"),
];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Gilroy', // Mengatur font default menjadi Gilroy
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Exclusive Order', style: TextStyle(fontFamily: 'Gilroy', fontWeight: FontWeight.bold)),
        ),
        body: ListView.builder(
          itemCount: exclusiveOffers.length,
          itemBuilder: (context, index) {
            final item = exclusiveOffers[index];
            return ListTile(
              leading: Image.asset(item.imagePath),
              title: Text(item.name, style: TextStyle(fontFamily: 'Gilroy')),
              subtitle: Text(item.description, style: TextStyle(fontFamily: 'Gilroy')),
              trailing: Text(formatPrice(item.price), style: TextStyle(fontFamily: 'Gilroy')),
            );
          },
        ),
      ),
    );
  }
}
