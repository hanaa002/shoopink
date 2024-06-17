import 'package:flutter/material.dart'; // Mengimpor paket dasar Flutter untuk pengembangan UI.
import 'package:shoopink/common_widgets/app_text.dart'; // Mengimpor widget teks kustom dari proyek.
import 'package:shoopink/models/grocery_item.dart'; // Mengimpor model GroceryItem untuk data item produk.
import 'package:shoopink/styles/colors.dart'; // Mengimpor warna kustom dari proyek.

class GroceryItemCardWidget extends StatelessWidget { // Widget untuk menampilkan kartu produk di dalam daftar.
  GroceryItemCardWidget({Key? key, required this.item, this.heroSuffix}) // Konstruktor widget dengan parameter wajib item dan opsional heroSuffix.
      : super(key: key); // Memanggil konstruktor superclass StatelessWidget dengan key yang diterima.

  final GroceryItem item; // Variabel final untuk menyimpan data GroceryItem.
  final String? heroSuffix; // Variabel final untuk menyimpan suffix untuk Hero animation.

  final double width = 174; // Lebar default untuk kartu produk.
  final double height = 250; // Tinggi default untuk kartu produk.
  final Color borderColor = Color(0xffE2E2E2); // Warna garis pinggir kartu produk.
  final double borderRadius = 18; // Radius sudut untuk border kartu produk.

  @override
  Widget build(BuildContext context) { // Build method untuk mengatur tampilan kartu produk.
    return Container( // Menggunakan Container sebagai wadah utama.
      width: width, // Mengatur lebar Container sesuai variabel width.
      height: height, // Mengatur tinggi Container sesuai variabel height.
      decoration: BoxDecoration( // Dekorasi untuk Container (border dan border radius).
        border: Border.all( // Menambahkan border dengan properti yang sudah ditentukan.
          color: borderColor, // Menggunakan warna borderColor yang sudah ditentukan.
        ),
        borderRadius: BorderRadius.circular( // Mengatur border radius sesuai dengan variabel borderRadius.
          borderRadius,
        ),
      ),
      child: Padding( // Menambahkan padding di dalam Container.
        padding: const EdgeInsets.symmetric( // Padding simetris horizontal dan vertikal.
          horizontal: 15, // Padding horizontal 15.
          vertical: 15, // Padding vertikal 15.
        ),
        child: Column( // Menggunakan Column untuk menyusun konten secara vertikal.
          crossAxisAlignment: CrossAxisAlignment.start, // Menyusun konten mulai dari kiri ke kanan.
          children: [
            Expanded( // Expanded untuk memastikan gambar berada di tengah.
              child: Center( // Menyusun gambar di tengah.
                child: Hero( // Widget Hero untuk animasi gambar saat berpindah halaman.
                  tag: "GroceryItem:" + item.name + "-" + (heroSuffix ?? ""), // Menentukan tag Hero dengan nama item dan suffix (jika ada).
                  child: imageWidget(), // Menampilkan gambar menggunakan method imageWidget().
                ),
              ),
            ),
            SizedBox( // SizedBox untuk memberikan jarak antara elemen.
              height: 20, // Tinggi SizedBox 20.
            ),
            AppText( // Widget kustom AppText untuk menampilkan nama produk.
              text: item.name, // Menggunakan nama produk dari GroceryItem.
              fontSize: 16, // Ukuran font 16.
              fontWeight: FontWeight.bold, // Ketebalan font bold.
            ),
            AppText( // Widget kustom AppText untuk menampilkan deskripsi produk.
              text: item.description, // Menggunakan deskripsi produk dari GroceryItem.
              fontSize: 14, // Ukuran font 14.
              fontWeight: FontWeight.w600, // Ketebalan font semi-bold.
              color: Color(0xFF7C7C7C), // Warna teks abu-abu.
            ),
            SizedBox( // SizedBox untuk memberikan jarak antara elemen.
              height: 20, // Tinggi SizedBox 20.
            ),
            Row( // Row untuk menyusun konten secara horizontal.
              children: [
                AppText( // Widget kustom AppText untuk menampilkan harga produk.
                  text: "Rp. ${item.price.toStringAsFixed(0)}", // Mengubah harga menjadi format rupiah.
                  fontSize: 18, // Ukuran font 18.
                  fontWeight: FontWeight.bold, // Ketebalan font bold.
                ),
                Spacer(), // Spacer untuk memberikan ruang antara elemen.
                addWidget() // Menampilkan widget tombol tambah menggunakan method addWidget().
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget imageWidget() { // Method untuk menampilkan gambar produk.
    return Container( // Container untuk gambar produk.
      child: Image.asset(item.imagePath), // Menampilkan gambar produk dari path yang tersimpan di GroceryItem.
    );
  }

  Widget addWidget() { // Method untuk menampilkan tombol tambah.
    return Container( // Container untuk tombol tambah.
      height: 45, // Tinggi tombol 45.
      width: 45, // Lebar tombol 45.
      decoration: BoxDecoration( // Dekorasi untuk container tombol tambah.
          borderRadius: BorderRadius.circular(17), // BorderRadius untuk sudut tombol.
          color: AppColors.primaryColor), // Warna latar belakang tombol menggunakan primaryColor dari AppColors.
      child: Center( // Center untuk menyusun icon tambah di tengah tombol.
        child: Icon( // Icon tambah.
          Icons.add, // Jenis icon tambah.
          color: Colors.white, // Warna icon putih.
          size: 25, // Ukuran icon 25.
        ),
      ),
    );
  }
}
