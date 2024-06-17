// login_screen.dart

// Import paket Flutter
import 'package:flutter/material.dart';
// Import Firebase Authentication
import 'package:firebase_auth/firebase_auth.dart';
// Import layar dashboard
import 'package:shoopink/screens/dashboard/dashboard_screen.dart';
// Import layar registrasi
import 'package:shoopink/screens/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import untuk mengakses shared preferences

// Definisikan kelas LoginScreen yang merupakan widget Stateful
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

// State untuk LoginScreen
class _LoginScreenState extends State<LoginScreen> {
  // Kontroler untuk input email
  final TextEditingController _emailController = TextEditingController();
  // Kontroler untuk input password
  final TextEditingController _passwordController = TextEditingController();
  // Instance FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Fungsi untuk login
  void _login() async {
    try {
      // Melakukan login dengan email dan password
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Get the user ID
      String userId = userCredential.user!.uid;

      // Save the user ID to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', userId);

      // Jika berhasil, navigasi ke layar dashboard
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) {
          return DashboardScreen();
        },
      ));
    } catch (e) {
      // Jika ada error, cetak errornya
      print(e);
    }
  }

  // Metode build untuk membangun tampilan widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Atur warna latar belakang scaffold
      backgroundColor: Colors.grey[100],
      // Padding untuk mengatur jarak dalam layar
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // Gunakan Center untuk menengahkan child-nya
        child: Center(
          // SingleChildScrollView untuk memungkinkan scrolling
          child: SingleChildScrollView(
            // Gunakan Column untuk menyusun widget secara vertikal
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Tampilkan logo
                Image.asset(
                  'assets/images/logoshoopink.png',
                  height: 100,
                ),
                SizedBox(height: 20), // Beri jarak vertikal
                // Tampilkan teks selamat datang
                Text(
                  'Selamat datang!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontFamily: 'Gilroy',
                  ),
                ),
                SizedBox(height: 20), // Beri jarak vertikal
                // TextField untuk username (dummy, tidak digunakan)
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Username',
                    labelStyle: TextStyle(fontFamily: 'Gilroy'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                SizedBox(height: 20), // Beri jarak vertikal
                // TextField untuk email
                TextField(
                  controller: _emailController, // Kontroler email
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Email',
                    labelStyle: TextStyle(fontFamily: 'Gilroy'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                SizedBox(height: 20), // Beri jarak vertikal
                // TextField untuk password
                TextField(
                  controller: _passwordController, // Kontroler password
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Password',
                    labelStyle: TextStyle(fontFamily: 'Gilroy'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  obscureText: true, // Menyembunyikan teks saat mengetik
                ),
                SizedBox(height: 20), // Beri jarak vertikal
                // Tombol untuk login
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent, // Warna latar tombol
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15), // Padding tombol
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0), // Radius border tombol
                    ),
                  ),
                  onPressed: _login, // Fungsi yang dijalankan saat tombol ditekan
                  child: Text('Masuk', style: TextStyle(fontSize: 18, fontFamily: 'Gilroy')), // Teks tombol
                ),
                SizedBox(height: 20), // Beri jarak vertikal
                // Teks tombol untuk navigasi ke layar registrasi
                TextButton(
                  onPressed: () {
                    // Navigasi ke layar registrasi
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) {
                        return RegisterScreen();
                      },
                    ));
                  },
                  child: Text(
                    'Belum punya akun? Daftar', // Teks tombol
                    style: TextStyle(color: Colors.greenAccent, fontFamily: 'Gilroy'), // Warna teks tombol
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
