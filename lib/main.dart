import 'package:flutter/material.dart';
import 'package:grocery_app/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashScreen(), // Atur SplashScreen sebagai home
    );
  }
}
