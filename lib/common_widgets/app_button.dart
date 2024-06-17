// Import paket Flutter yang diperlukan
import 'package:flutter/material.dart';
// Import warna aplikasi dari file styles/colors.dart
import 'package:shoopink/styles/colors.dart';

// Deklarasi class AppButton yang merupakan stateless widget
class AppButton extends StatelessWidget {
  // Deklarasi variabel final untuk properti tombol
  final String label; // Label untuk tombol
  final double roundness; // Tingkat kelengkungan sudut tombol
  final FontWeight fontWeight; // Ketebalan font untuk teks tombol
  final EdgeInsets padding; // Padding untuk tombol
  final Widget? trailingWidget; // Widget tambahan di bagian akhir tombol
  final Function? onPressed; // Fungsi yang dipanggil saat tombol ditekan
  final Color color; // Warna tombol
  final Color textColor; // Warna teks tombol

  // Constructor untuk AppButton dengan parameter yang diperlukan
  const AppButton({
    Key? key,
    required this.label,
    this.roundness = 18, // Default roundness
    this.fontWeight = FontWeight.bold, // Default font weight
    this.padding = const EdgeInsets.symmetric(vertical: 24), // Default padding
    this.trailingWidget, // Trailing widget opsional
    this.onPressed, // Fungsi onPressed opsional
    this.color = AppColors.primaryColor, // Default button color
    this.textColor = Colors.white, // Default text color
  }) : super(key: key); // Memanggil constructor superclass

  // Override method build untuk membangun UI
  @override
  Widget build(BuildContext context) {
    // Mengembalikan Container untuk membungkus ElevatedButton
    return Container(
      width: double.maxFinite, // Lebar tombol maksimum
      child: ElevatedButton(
        // Fungsi yang dipanggil saat tombol ditekan
        onPressed: () {
          onPressed?.call(); // Memanggil fungsi onPressed jika tidak null
        },
        // Mengatur gaya untuk ElevatedButton
        style: ElevatedButton.styleFrom(
          visualDensity: VisualDensity.compact, // Mengatur visual density
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(roundness), // Mengatur kelengkungan sudut
          ),
          elevation: 0, // Tidak ada bayangan
          backgroundColor: color, // Menggunakan warna tombol dari parameter
          textStyle: TextStyle(
            color: textColor, // Menggunakan warna teks dari parameter
            fontFamily: Theme.of(context).textTheme.bodyText1?.fontFamily, // Menggunakan font family dari tema
            fontWeight: fontWeight, // Mengatur ketebalan font
          ),
          padding: padding, // Menggunakan padding dari parameter
          minimumSize: const Size.fromHeight(50), // Ukuran minimum tombol
        ),
        // Mengatur anak-anak dari ElevatedButton
        child: Stack(
          fit: StackFit.passthrough, // Mengatur fit stack
          children: <Widget>[
            // Menempatkan teks di tengah tombol
            Center(
              child: Text(
                label, // Label tombol
                textAlign: TextAlign.center, // Mengatur teks agar berada di tengah
                style: TextStyle(
                  fontSize: 18, // Ukuran font
                  fontWeight: fontWeight, // Ketebalan font
                  color: textColor, // Menggunakan warna teks dari parameter
                ),
              ),
            ),
            // Menempatkan trailing widget jika tidak null
            if (trailingWidget != null)
              Positioned(
                top: 0, // Posisi dari atas
                right: 25, // Posisi dari kanan
                child: trailingWidget!, // Trailing widget
              ),
          ],
        ),
      ),
    );
  }
}
