import 'dart:async'; // Mengimpor pustaka dart:async untuk menggunakan Future dan Timer
import 'package:flutter/material.dart'; // Mengimpor pustaka dasar Flutter untuk membangun UI
import 'package:shoopink/screens/welcome_screen.dart'; // Mengimpor layar WelcomeScreen untuk navigasi setelah SplashScreen

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState(); // Membuat stateful widget SplashScreen
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()), // Navigasi ke WelcomeScreen setelah 3 detik
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 218, 94), // Warna latar belakang SplashScreen
      body: Center(
        child: splashScreenContent(), // Memuat konten SplashScreen di tengah layar
      ),
    );
  }

  Widget splashScreenContent() {
    final String logoPath = "assets/images/logoshoopink.png"; // Path untuk gambar logo

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          logoPath, // Menampilkan gambar logo
          width: 100,
          height: 100,
        ),
        SizedBox(height: 20), // Jarak vertikal antara gambar dan teks
        Text(
          "SHOPINK", // Judul aplikasi
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Warna teks
            fontFamily: 'Gilroy',
          ),
        ),
      ],
    );
  }
}
