// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoopink/providers/cart_provider.dart';
import 'package:shoopink/screens/splash_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}
