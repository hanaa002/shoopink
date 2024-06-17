// Import package Flutter
import 'package:flutter/material.dart';
// Import Firebase Authentication
import 'package:firebase_auth/firebase_auth.dart';
// Import LoginScreen untuk navigasi setelah registrasi berhasil
import 'package:shoopink/screens/login_screen.dart';

// Definisikan kelas RegisterScreen sebagai StatelessWidget
class RegisterScreen extends StatelessWidget {
  // Kontroler untuk input username
  final TextEditingController usernameController = TextEditingController();
  // Kontroler untuk input email
  final TextEditingController emailController = TextEditingController();
  // Kontroler untuk input password
  final TextEditingController passwordController = TextEditingController();
  // Kontroler untuk input konfirmasi password
  final TextEditingController confirmPasswordController = TextEditingController();

  // Fungsi untuk registrasi
  Future<void> register(BuildContext context) async {
    try {
      // Validasi apakah password dan konfirmasi password sesuai
      if (passwordController.text != confirmPasswordController.text) {
        throw FirebaseAuthException(
          code: 'password-mismatch', // Kode error untuk password tidak sesuai
          message: 'Password tidak sesuai.', // Pesan error untuk password tidak sesuai
        );
      }

      // Buat pengguna baru dengan email dan password
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Update profil pengguna dengan username
      await userCredential.user!.updateDisplayName(usernameController.text.trim());

      // Navigasi ke LoginScreen setelah registrasi berhasil
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),
      );
    } on FirebaseAuthException catch (e) {
      // Tampilkan dialog jika terjadi error saat registrasi
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registrasi gagal', style: TextStyle(fontFamily: 'Gilroy')),
            content: Text(e.message ?? 'Terjadi kesalahan', style: TextStyle(fontFamily: 'Gilroy')), // Tampilkan pesan error
            actions: <Widget>[
              TextButton(
                child: Text('OK', style: TextStyle(fontFamily: 'Gilroy')),
                onPressed: () {
                  Navigator.of(context).pop(); // Tutup dialog
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Jika terjadi error lainnya, cetak pesan error
      print(e.toString());
    }
  }

  // Metode build untuk membangun tampilan widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Atur warna latar belakang scaffold
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding untuk mengatur jarak dalam layar
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Tampilkan logo
                Image.asset(
                  'assets/images/logoshoopink.png', // Path ke logo
                  height: 100,
                ),
                SizedBox(height: 20), // Beri jarak vertikal
                Text(
                  'Buat Akun', // Teks header
                  style: TextStyle(
                    fontSize: 24, // Ukuran font
                    fontWeight: FontWeight.bold, // Ketebalan font
                    color: Colors.black87, // Warna font
                    fontFamily: 'Gilroy', // Ganti font menjadi Gilroy
                  ),
                ),
                SizedBox(height: 20), // Beri jarak vertikal
                // TextField untuk input username
                TextField(
                  controller: usernameController, // Kontroler username
                  decoration: InputDecoration(
                    filled: true, // Mengisi latar belakang
                    fillColor: Colors.white, // Warna latar belakang
                    labelText: 'Username', // Label untuk TextField
                    labelStyle: TextStyle(fontFamily: 'Gilroy'), // Ganti font menjadi Gilroy
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0), // Radius border
                    ),
                  ),
                ),
                SizedBox(height: 20), // Beri jarak vertikal
                // TextField untuk input email
                TextField(
                  controller: emailController, // Kontroler email
                  decoration: InputDecoration(
                    filled: true, // Mengisi latar belakang
                    fillColor: Colors.white, // Warna latar belakang
                    labelText: 'Email', // Label untuk TextField
                    labelStyle: TextStyle(fontFamily: 'Gilroy'), // Ganti font menjadi Gilroy
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0), // Radius border
                    ),
                  ),
                ),
                SizedBox(height: 20), // Beri jarak vertikal
                // TextField untuk input password
                TextField(
                  controller: passwordController, // Kontroler password
                  decoration: InputDecoration(
                    filled: true, // Mengisi latar belakang
                    fillColor: Colors.white, // Warna latar belakang
                    labelText: 'Password', // Label untuk TextField
                    labelStyle: TextStyle(fontFamily: 'Gilroy'), // Ganti font menjadi Gilroy
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0), // Radius border
                    ),
                  ),
                  obscureText: true, // Menyembunyikan teks saat mengetik
                ),
                SizedBox(height: 20), // Beri jarak vertikal
                // TextField untuk input konfirmasi password
                TextField(
                  controller: confirmPasswordController, // Kontroler konfirmasi password
                  decoration: InputDecoration(
                    filled: true, // Mengisi latar belakang
                    fillColor: Colors.white, // Warna latar belakang
                    labelText: 'Konfirmasi Password', // Label untuk TextField
                    labelStyle: TextStyle(fontFamily: 'Gilroy'), // Ganti font menjadi Gilroy
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0), // Radius border
                    ),
                  ),
                  obscureText: true, // Menyembunyikan teks saat mengetik
                ),
                SizedBox(height: 20), // Beri jarak vertikal
                // Tombol untuk melakukan registrasi
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent, // Warna latar tombol
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15), // Padding tombol
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0), // Radius border tombol
                    ),
                  ),
                  onPressed: () {
                    register(context); // Panggil metode registrasi
                  },
                  child: Text('Daftar', style: TextStyle(fontSize: 18, fontFamily: 'Gilroy')), // Teks tombol
                ),
                SizedBox(height: 20), // Beri jarak vertikal
                // Teks tombol untuk navigasi kembali ke LoginScreen
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Navigasi kembali ke layar sebelumnya (LoginScreen)
                  },
                  child: Text(
                    'Sudah punya akun? Masuk', // Teks tombol
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
