import 'package:flutter/material.dart'; // Mengimpor pustaka dasar Flutter untuk membangun UI
import 'package:shoopink/styles/colors.dart'; // Mengimpor file colors.dart untuk mengakses palet warna aplikasi

String gilroyFontFamily = "Gilroy"; // Mendefinisikan nama font family yang digunakan di aplikasi

ThemeData themeData = ThemeData(
  fontFamily: gilroyFontFamily, // Menetapkan font family default untuk tema aplikasi
  visualDensity: VisualDensity.adaptivePlatformDensity, // Mengatur kepadatan visual sesuai dengan platform
  colorScheme:
      ColorScheme.fromSwatch().copyWith(secondary: AppColors.primaryColor), // Mengambil skema warna bawaan dan menyesuaikan warna sekunder dengan primaryColor dari AppColors
);
