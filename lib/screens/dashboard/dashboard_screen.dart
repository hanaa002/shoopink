// Import package Flutter
import 'package:flutter/material.dart';
// Import file navigator_item.dart yang berisi item navigasi
import 'navigator_item.dart';

// Definisikan kelas DashboardScreen sebagai StatefulWidget
class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

// Definisikan state untuk DashboardScreen
class _DashboardScreenState extends State<DashboardScreen> {
  // Indeks saat ini untuk item navigasi
  int currentIndex = 0;

  // Metode build untuk membangun tampilan widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Atur konten tubuh berdasarkan item navigasi yang dipilih
      body: navigatorItems[currentIndex].screen,
      // Atur bottom navigation bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15), // Radius untuk sudut kanan atas
            topLeft: Radius.circular(15), // Radius untuk sudut kiri atas
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black38.withOpacity(0.1), // Warna bayangan
              spreadRadius: 0, // Radius penyebaran bayangan
              blurRadius: 37, // Radius blur bayangan
              offset: Offset(0, -12), // Offset bayangan
            ),
          ],
        ),
        // Mengatur border radius untuk clip pada bottom navigation bar
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), // Radius untuk sudut kiri atas
            topRight: Radius.circular(15), // Radius untuk sudut kanan atas
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white, // Warna latar belakang navigation bar
            currentIndex: currentIndex, // Indeks item saat ini
            onTap: (index) {
              // Ubah state saat item navigation bar ditekan
              setState(() {
                currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed, // Tipe navigation bar
            selectedItemColor: Colors.green, // Warna item terpilih
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600), // Gaya label item terpilih
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600), // Gaya label item tidak terpilih
            unselectedItemColor: Colors.black, // Warna item tidak terpilih
            items: navigatorItems.map((e) {
              // Iterasi melalui setiap item navigasi
              return getNavigationBarItem(
                label: e.label, // Label untuk item navigasi
                index: e.index, // Indeks item navigasi
                icon: e.icon, // Ikon untuk item navigasi
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  // Fungsi untuk mendapatkan BottomNavigationBarItem
  BottomNavigationBarItem getNavigationBarItem({
    required String label, // Label item navigasi
    required IconData icon, // Ikon item navigasi
    required int index, // Indeks item navigasi
  }) {
    // Atur warna ikon berdasarkan apakah item terpilih atau tidak
    Color iconColor = index == currentIndex ? Colors.green : Colors.black;
    return BottomNavigationBarItem(
      label: label, // Label untuk item
      icon: Icon(
        icon, // Ikon untuk item
        color: iconColor, // Warna ikon
      ),
    );
  }
}
