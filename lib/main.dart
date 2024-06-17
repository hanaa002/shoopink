// Import paket dart:io untuk kebutuhan I/O dasar
import 'dart:io';

// Import paket Flutter yang diperlukan
import 'package:flutter/material.dart';
// Import paket provider untuk state management
import 'package:provider/provider.dart';
// Import CartProvider untuk mengelola data keranjang
import 'package:shoopink/providers/cart_provider.dart';
// Import SplashScreen untuk tampilan awal aplikasi
import 'package:shoopink/screens/splash_screen.dart';
// Import WelcomeScreen untuk tampilan selamat datang
import 'package:shoopink/screens/welcome_screen.dart';
// Import DashboardScreen untuk tampilan utama setelah login
import 'package:shoopink/screens/dashboard/dashboard_screen.dart';
// Import paket Firebase core untuk inisialisasi Firebase
import 'package:firebase_core/firebase_core.dart';
// Import file konfigurasi Firebase
import 'package:shoopink/firebase_options.dart';
// Import FirebaseAuth untuk autentikasi pengguna
import 'package:firebase_auth/firebase_auth.dart';

// Fungsi utama untuk menjalankan aplikasi Flutter
void main() async {
  // Pastikan binding widget telah terinisialisasi sebelum menjalankan aplikasi
  WidgetsFlutterBinding.ensureInitialized();
  // Inisialisasi Firebase dengan opsi platform saat ini
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Menjalankan aplikasi Flutter dengan MultiProvider untuk state management
  runApp(MultiProvider(
    // Daftar provider yang akan digunakan dalam aplikasi
    providers: [
      // Provider untuk CartProvider
      ChangeNotifierProvider(create: (context) => CartProvider()),
      // Provider untuk Stream auth state Firebase
      StreamProvider<User?>.value(value: FirebaseAuth.instance.authStateChanges(), initialData: null,),
    ],
    // MaterialApp sebagai root aplikasi
    child: MaterialApp(
      home: MyApp(),
    ),
  ));
}

// Class MyApp yang merupakan stateless widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mengembalikan MaterialApp dengan AuthWrapper sebagai home
    return MaterialApp(
      home: AuthWrapper(),
    );
  }
}

// Class AuthWrapper yang merupakan stateless widget
class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // StreamBuilder untuk memantau perubahan status autentikasi
    return StreamBuilder<User?>(
      // Stream untuk perubahan status autentikasi Firebase
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Jika koneksi sedang menunggu
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Tampilkan WelcomeScreen saat menunggu
          return WelcomeScreen();
        // Jika ada data (user sedang login)
        } else if (snapshot.hasData) {
          // Tampilkan DashboardScreen jika user sudah login
          return DashboardScreen();
        } else {
          // Tampilkan WelcomeScreen jika tidak ada user yang login
          return SplashScreen();
        }
      },
    );
  }
}
