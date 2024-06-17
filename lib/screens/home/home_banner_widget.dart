import 'package:flutter/material.dart'; // Mengimpor paket Flutter yang diperlukan.
import 'package:shoopink/common_widgets/app_text.dart'; // Mengimpor widget kustom 'AppText' dari path yang ditentukan.
import 'package:shoopink/styles/colors.dart'; // Mengimpor file warna yang digunakan dalam aplikasi.

class HomeBanner extends StatelessWidget { // Mendefinisikan kelas 'HomeBanner' sebagai StatelessWidget.
  @override
  Widget build(BuildContext context) { // Metode build untuk membangun widget UI.
    return Container( // Menggunakan widget Container sebagai wadah utama.
      width: 500, // Lebar container diatur menjadi 500.
      height: 115, // Tinggi container diatur menjadi 115.
      decoration: BoxDecoration( // Menambahkan dekorasi pada container.
          borderRadius: BorderRadius.circular(15), // Menambahkan border radius sebesar 15.
          image: DecorationImage( // Menambahkan gambar latar belakang pada container.
              image: AssetImage( // Menggunakan gambar dari aset.
                "assets/images/banner_background.png", // Lokasi gambar latar belakang.
              ),
              fit: BoxFit.cover)), // Menyesuaikan gambar agar menutupi seluruh container.
      child: Row( // Menggunakan widget Row untuk mengatur widget secara horizontal.
        children: [ // Daftar widget yang merupakan anak dari Row.
          Container( // Menggunakan Container untuk mengatur padding gambar.
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10), // Menambahkan padding secara simetris.
            child: Image.asset( // Menambahkan gambar ke dalam container.
              "assets/images/banner_image.png", // Lokasi gambar aset.
            ),
          ),
          Spacer(), // Menambahkan ruang kosong di antara widget gambar dan teks.
          Column( // Menggunakan Column untuk mengatur widget secara vertikal.
            mainAxisAlignment: MainAxisAlignment.center, // Mengatur widget agar berada di tengah secara vertikal.
            children: [ // Daftar widget yang merupakan anak dari Column.
              AppText( // Menggunakan widget kustom 'AppText' untuk teks.
                text: "Sayur Segar", // Teks yang ditampilkan.
                fontSize: 22, // Ukuran font teks.
                fontWeight: FontWeight.bold, // Ketebalan font teks.
                fontFamily: 'Gilroy'
              ),
              AppText( // Menggunakan widget kustom 'AppText' untuk teks kedua.
                text: "Diskon 40%", // Teks yang ditampilkan.
                fontSize: 16, // Ukuran font teks.
                fontWeight: FontWeight.w600, // Ketebalan font teks.
                color: AppColors.primaryColor, // Warna teks menggunakan warna kustom dari 'AppColors'.
                fontFamily: 'Gilroy'
              ),
            ],
          ),
          SizedBox( // Menggunakan SizedBox untuk menambahkan ruang di akhir Row.
            width: 20, // Lebar dari SizedBox.
          )
        ],
      ),
    );
  }
}
