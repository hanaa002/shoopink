import 'package:flutter/material.dart';
import 'package:grocery_app/screens/dashboard/dashboard_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.shopping_cart,
                size: 100,
                color: Colors.green, // Ubah menjadi warna hijau
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Ganti navigasi ke DashboardScreen setelah login berhasil
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) {
                      return DashboardScreen();
                    },
                  ));
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
