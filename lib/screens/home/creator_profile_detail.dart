import 'package:flutter/material.dart';
import 'package:shoopink/screens/home/creator_profile.dart'; // Import file creator_profile.dart untuk mengakses data CreatorProfile

// Kelas untuk halaman detail profil pengembang
class CreatorProfileDetail extends StatelessWidget {
  final CreatorProfile profile; // Data profil pengembang yang akan ditampilkan

  // Constructor untuk menginisialisasi profil pengembang
  CreatorProfileDetail({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Warna latar belakang putih
      appBar: AppBar(
        backgroundColor: Colors.white, // Warna latar belakang AppBar putih
        title: Text(
          'Detail Profil Pengembang', // Judul AppBar
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Gilroy'), // Gaya teks judul tebal (bold)
        ),
        centerTitle: true, // Posisi judul ditengah AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding untuk konten
        child: Column(
          children: [
            SizedBox(height: 20), // Spacer vertikal dengan ukuran 20
            Center(
              child: CircleAvatar(
                radius: 70, // Radius Avatar lingkaran
                backgroundImage: AssetImage(profile.image), // Gambar avatar dari profil pengembang
                backgroundColor: Colors.transparent, // Hapus latar belakang avatar
              ),
            ),
            SizedBox(height: 20), // Spacer vertikal dengan ukuran 20
            Text(
              profile.fullName, // Nama lengkap pengembang
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold, // Teks nama tebal (bold)
                color: Colors.black87, // Warna teks hitam
                fontFamily: 'Gilroy', // Menggunakan font Gilroy di sini.
              ),
            ),
            SizedBox(height: 10), // Spacer vertikal dengan ukuran 10
            Text(
              profile.university, // Universitas pengembang
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic, // Teks kursif (italic)
                color: Colors.black54, // Warna teks abu-abu
                fontFamily: 'Gilroy', // Menggunakan font Gilroy di sini.
              ),
            ),
            SizedBox(height: 20), // Spacer vertikal dengan ukuran 20
            Divider(), // Garis pemisah
            Expanded(
              child: ListView( // Menggunakan ListView sebagai wadah untuk item-item detail
                children: [
                  // Widget untuk menampilkan detail fakultas
                  ProfileDetailItem(
                    icon: Icons.school,
                    title: 'Fakultas',
                    subtitle: profile.faculty,
                    backgroundColor: const Color.fromARGB(255, 123, 188, 125), // Warna latar belakang item detail
                    textColor: Colors.white, // Warna teks item detail
                    fontFamily: 'Gilroy', // Menggunakan font Gilroy di sini.
                  ),
                  // Widget untuk menampilkan detail jurusan
                  ProfileDetailItem(
                    icon: Icons.code,
                    title: 'Jurusan',
                    subtitle: profile.major,
                    backgroundColor: const Color.fromARGB(255, 123, 188, 125),
                    textColor: Colors.white,
                    fontFamily: 'Gilroy', // Menggunakan font Gilroy di sini.
                  ),
                  // Widget untuk menampilkan detail NPM
                  ProfileDetailItem(
                    icon: Icons.badge,
                    title: 'NPM',
                    subtitle: profile.npm,
                    backgroundColor: const Color.fromARGB(255, 123, 188, 125),
                    textColor: Colors.white,
                    fontFamily: 'Gilroy', // Menggunakan font Gilroy di sini.
                  ),
                  // Widget untuk menampilkan detail email
                  ProfileDetailItem(
                    icon: Icons.email,
                    title: 'Email',
                    subtitle: profile.email,
                    backgroundColor: const Color.fromARGB(255, 123, 188, 125),
                    textColor: Colors.white,
                    fontFamily: 'Gilroy', // Menggunakan font Gilroy di sini.
                  ),
                  // Widget untuk menampilkan detail GitHub
                  ProfileDetailItem(
                    icon: Icons.link,
                    title: 'GitHub',
                    subtitle: profile.github,
                    backgroundColor: const Color.fromARGB(255, 123, 188, 125),
                    textColor: Colors.white,
                    fontFamily: 'Gilroy', // Menggunakan font Gilroy di sini.
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget untuk menampilkan item detail profil
class ProfileDetailItem extends StatelessWidget {
  final IconData icon; // Ikona untuk item detail
  final String title; // Judul untuk item detail
  final String subtitle; // Subjudul atau nilai untuk item detail
  final Color backgroundColor; // Warna latar belakang item
  final Color textColor; // Warna teks item
  final String fontFamily; // Font family untuk teks

  // Constructor untuk inisialisasi item detail
  ProfileDetailItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
    required this.textColor,
    this.fontFamily = 'Gilroy', // Mengatur default font family Gilroy
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0, // Tidak ada bayangan untuk Card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Bentuk lingkaran untuk Card
      ),
      color: backgroundColor, // Warna latar belakang Card
      margin: EdgeInsets.symmetric(vertical: 8.0), // Margin vertikal untuk Card
      child: ListTile(
        leading: Icon(icon, color: const Color.fromARGB(255, 255, 255, 255)), // Icon di sebelah kiri ListTile
        title: Text(
          title, // Judul item detail
          style: TextStyle(
            fontWeight: FontWeight.bold, // Teks judul tebal (bold)
            color: textColor, // Warna teks judul
            fontFamily: fontFamily, // Menggunakan font family yang diberikan
          ),
        ),
        subtitle: Text(
          subtitle, // Nilai atau subjudul item detail
          style: TextStyle(
            color: textColor, // Warna teks nilai atau subjudul
            fontFamily: fontFamily, // Menggunakan font family yang diberikan
          ),
        ),
      ),
    );
  }
}
