import 'package:flutter/material.dart'; // Mengimpor package Flutter material untuk membangun antarmuka pengguna.

class SearchBarWidget extends StatelessWidget { // Mendefinisikan kelas SearchBarWidget yang merupakan StatelessWidget.
  final ValueChanged<String> onSearch; // Deklarasi variabel onSearch yang menerima fungsi untuk menangani perubahan teks.

  SearchBarWidget({required this.onSearch}); // Konstruktor untuk menginisialisasi variabel onSearch yang wajib diisi.

  @override
  Widget build(BuildContext context) { // Metode build untuk membangun antarmuka widget.
    return Container( // Menggunakan widget Container sebagai pembungkus utama.
      padding: EdgeInsets.symmetric(horizontal: 25), // Memberikan padding horizontal pada Container.
      child: TextField( // Menggunakan widget TextField untuk membuat input teks.
        onChanged: onSearch, // Menghubungkan fungsi onSearch dengan properti onChanged pada TextField.
        decoration: InputDecoration( // Mengatur dekorasi untuk TextField.
          prefixIcon: Icon(Icons.search), // Menambahkan ikon pencarian di sebelah kiri TextField.
          hintText: "Cari", // Menampilkan teks petunjuk "Cari" dalam TextField.
          border: OutlineInputBorder( // Mengatur border pada TextField.
            borderRadius: BorderRadius.circular(10), // Memberikan radius pada border agar sudutnya melengkung.
            borderSide: BorderSide.none, // Menghilangkan border default pada TextField.
          ),
          filled: true, // Mengaktifkan latar belakang yang terisi warna.
          fillColor: Colors.grey[200], // Memberikan warna abu-abu muda sebagai latar belakang TextField.
          contentPadding: EdgeInsets.zero, // Mengatur padding konten menjadi nol.
        ),
      ),
    );
  }
}
