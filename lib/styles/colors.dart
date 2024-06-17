import 'dart:ui'; // Mengimpor pustaka dart:ui untuk mengakses kelas Color

import 'package:flutter/material.dart'; // Mengimpor pustaka dasar Flutter untuk membangun UI

class AppColors {
  //One instance, needs factory
  static AppColors? _instance; // Deklarasi variabel instance AppColors yang bersifat statis dan bisa bernilai null
  factory AppColors() => _instance ??= AppColors._(); // Factory constructor untuk mengembalikan instance tunggal dari AppColors

  AppColors._(); // Constructor pribadi untuk memastikan hanya satu instance yang dibuat

  static const primaryColor = Color.fromARGB(255, 0, 218, 94); // Warna utama aplikasi (hijau)
  static const darkGrey = Color(0xff7C7C7C); // Warna abu-abu gelap
}
