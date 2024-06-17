//prder_accepted_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoopink/providers/cart_provider.dart';
import 'package:shoopink/screens/dashboard/dashboard_screen.dart';

class OrderAcceptedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.fromLTRB(25, 50, 25, 0), // Padding atas diperbesar menjadi 50 untuk menaikkan konten ke atas.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center, // Menyusun konten ke tengah secara vertikal.
          children: [
            Icon(Icons.check_circle, size: 100, color: Colors.green),
            SizedBox(height: 20), // Spacer vertikal dengan ukuran 20.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Pesanan Anda telah diterima",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28, fontFamily: 'Gilroy'),
              ),
            ),
            SizedBox(height: 10), // Spacer vertikal dengan ukuran 10.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Barang Anda sedang di proses",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Gilroy',
                  color: Color(0xff7C7C7C),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Spacer(), // Spacer mengisi sisa ruang kosong di antara teks dan tombol.
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 0, 218, 94)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false).clearCart();
               Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return DashboardScreen();
                  },
                ));
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  "Selesai",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Gilroy'),
                ),
              ),
            ),
            SizedBox(height: 20), // Spacer vertikal dengan ukuran 20 setelah tombol.
          ],
        ),
      ),
    );
  }
}
