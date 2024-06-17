import 'package:flutter/material.dart'; // Mengimpor package flutter/material.dart untuk menggunakan Flutter UI framework.

class SearchBarWidget extends StatelessWidget { // Deklarasi class SearchBarWidget sebagai StatelessWidget.
  @override
  Widget build(BuildContext context) { // Method build untuk membangun tampilan widget.
    return Container( // Menggunakan Container sebagai parent widget.
      padding: EdgeInsets.all(16), // Padding untuk semua sisi Container.
      width: double.maxFinite, // Lebar Container mengikuti lebar maksimum yang tersedia.
      decoration: BoxDecoration( // Mendefinisikan dekorasi Container.
        color: Color(0xFFF2F3F2), // Warna latar belakang Container.
        borderRadius: BorderRadius.circular(20), // BorderRadius untuk sudut Container.
      ),
      child: Row( // Menggunakan Row untuk menyusun widget secara horizontal.
        mainAxisAlignment: MainAxisAlignment.start, // Menyusun widget mulai dari kiri.
        children: [
          Icon( // Widget Icon untuk menampilkan ikon search.
            Icons.search, // Menggunakan ikon search.
            color: Color(0xFF7C7C7C), // Warna ikon.
          ),
          SizedBox( // SizedBox untuk memberikan jarak horizontal.
            width: 8, // Lebar SizedBox.
          ),
          Text( // Widget Text untuk menampilkan teks "Cari Produk".
            "Cari Produk", // Teks yang ditampilkan.
            style: TextStyle( // Style untuk teks.
              fontSize: 18, // Ukuran teks.
              fontWeight: FontWeight.bold, // Ketebalan teks.
              color: Color(0xFF7C7C7C), // Warna teks.
            ),
          )
        ],
      ),
    );
  }
}
