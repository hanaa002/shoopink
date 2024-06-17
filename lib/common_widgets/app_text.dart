// Import paket Flutter yang diperlukan
import 'package:flutter/material.dart';

// Deklarasi class AppText yang merupakan stateless widget
class AppText extends StatelessWidget {
  // Deklarasi variabel final untuk properti teks
  final String text; // Teks yang akan ditampilkan
  final double fontSize; // Ukuran font teks
  final FontWeight fontWeight; // Ketebalan font untuk teks
  final Color color; // Warna teks
  final TextAlign? textAlign; // Pengaturan alignment teks, opsional
  final String? fontFamily; // Properti fontFamily untuk jenis font

  // Constructor untuk AppText dengan parameter yang diperlukan
  const AppText({
    Key? key,
    required this.text, // Teks adalah parameter wajib
    this.fontSize = 18, // Default ukuran font
    this.fontWeight = FontWeight.normal, // Default ketebalan font
    this.color = Colors.black, // Default warna teks
    this.textAlign, // Alignment teks opsional
    this.fontFamily, // Properti fontFamily opsional untuk jenis font
  }) : super(key: key); // Memanggil constructor superclass

  // Override method build untuk membangun UI
  @override
  Widget build(BuildContext context) {
    // Mengembalikan widget Text untuk menampilkan teks
    return Text(
      text, // Teks yang ditampilkan
      textAlign: textAlign, // Mengatur alignment teks
      style: TextStyle(
        fontSize: fontSize, // Menggunakan ukuran font dari parameter
        fontWeight: fontWeight, // Menggunakan ketebalan font dari parameter
        color: color, // Menggunakan warna teks dari parameter
        fontFamily: fontFamily, // Menggunakan jenis font dari parameter
      ),
    );
  }
}
