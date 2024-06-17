// Import paket Flutter yang diperlukan
import 'package:flutter/material.dart';
// Import SplashScreen untuk tampilan awal aplikasi
import 'package:shoopink/screens/splash_screen.dart';
// Import tema aplikasi dari file styles/theme.dart
import 'package:shoopink/styles/theme.dart';

// Class MyApp yang merupakan stateless widget
class MyApp extends StatelessWidget {
  // Override method build untuk membangun UI
  @override
  Widget build(BuildContext context) {
    // Mengembalikan MaterialApp sebagai root aplikasi
    return MaterialApp(
      // Menetapkan tema aplikasi
      theme: themeData,
      // Menetapkan SplashScreen sebagai halaman utama
      home: SplashScreen(),
    );
  }
}
