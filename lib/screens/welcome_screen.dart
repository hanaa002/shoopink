// welcome_screen.dart

// Import paket Flutter
import 'package:flutter/material.dart';
// Import widget kustom
import 'package:shoopink/common_widgets/app_button.dart';
import 'package:shoopink/common_widgets/app_text.dart';
// Import layar login
import 'package:shoopink/screens/login_screen.dart';
// Import warna kustom
import 'package:shoopink/styles/colors.dart';

// Definisikan kelas WelcomeScreen yang merupakan widget Stateless
class WelcomeScreen extends StatelessWidget {
  // Path untuk gambar latar belakang
  final String imagePath = "assets/images/welcomesplashscreen.png";
  // Path untuk logo
  final String logoPath = "assets/images/logoshoopink.png";

  // Metode build untuk membangun tampilan widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Atur warna latar belakang scaffold
      backgroundColor: AppColors.primaryColor,
      // Gunakan container untuk menampung dekorasi dan padding
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          // Atur gambar latar belakang
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover, // Atur gambar agar menutupi seluruh area
          ),
        ),
        // Gunakan Center untuk menengahkan child-nya
        child: Center(
          // Gunakan Column untuk menyusun widget secara vertikal
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Spacer(), // Tambahkan spacer untuk memberi ruang kosong
              icon(), // Tampilkan logo
              SizedBox(height: 20), // Beri jarak vertikal
              welcomeTextWidget(), // Tampilkan teks selamat datang
              SizedBox(height: 10), // Beri jarak vertikal
              sloganText(), // Tampilkan teks slogan
              SizedBox(height: 40), // Beri jarak vertikal
              getButton(context), // Tampilkan tombol
              SizedBox(height: 40), // Beri jarak vertikal
            ],
          ),
        ),
      ),
    );
  }

  // Metode untuk menampilkan ikon/logo
  Widget icon() {
    return Image.asset(
      logoPath, // Path ke logo
      width: 100, // Lebar logo
      height: 100, // Tinggi logo
    );
  }

  // Metode untuk menampilkan widget teks selamat datang
  Widget welcomeTextWidget() {
    return Column(
      children: [
        // Widget teks kustom untuk "Selamat datang"
        AppText(
          text: "Selamat datang",
          fontSize: 48,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontFamily: 'Gilroy',
        ),
        // Widget teks kustom untuk "di toko kami"
        AppText(
          text: "di toko kami",
          fontSize: 48,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontFamily: 'Gilroy',
        ),
      ],
    );
  }

  // Metode untuk menampilkan teks slogan
  Widget sloganText() {
    return AppText(
      text: "Dapatkan belanjaan anda dengan praktis",
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Color(0xffFCFCFC).withOpacity(0.7), // Warna teks dengan opacity
      fontFamily: 'Gilroy',
    );
  }

  // Metode untuk menampilkan tombol
  Widget getButton(BuildContext context) {
    return Container(
      width: double.infinity, // Lebar tombol memenuhi lebar parent
      child: AppButton(
        label: "Mulai", // Label tombol
        fontWeight: FontWeight.w600, // Berat font
        padding: EdgeInsets.symmetric(vertical: 25), // Padding vertikal
        onPressed: () {
          // Aksi saat tombol ditekan
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) {
              return LoginScreen(); // Navigasi ke layar login
            },
          ));
        },
        color: Color.fromARGB(255, 0, 218, 94), // Warna latar tombol
        textColor: Colors.white, // Warna teks tombol
      ),
    );
  }
}
