import 'package:flutter/material.dart'; // Mengimpor paket dasar Flutter untuk pengembangan UI.
import 'package:shoopink/common_widgets/app_text.dart'; // Mengimpor widget teks kustom dari proyek.
import 'package:shoopink/models/grocery_item.dart'; // Mengimpor model GroceryItem untuk data item produk.
import 'package:shoopink/styles/colors.dart'; // Mengimpor warna kustom dari proyek.

import 'item_counter_widget.dart'; // Mengimpor widget ItemCounterWidget untuk menangani perubahan jumlah produk.

class ChartItemWidget extends StatefulWidget { // Widget untuk menampilkan item di dalam keranjang belanja (cart).
  ChartItemWidget({ // Konstruktor widget dengan parameter wajib item, onRemove, amount, dan onQuantityChanged.
    Key? key,
    required this.item,
    required this.onRemove,
    required this.amount, // Menambahkan parameter amount di sini untuk jumlah produk.
    required this.onQuantityChanged, // Memperbarui tanda tangan callback.
  }) : super(key: key);

  final GroceryItem item; // Variabel final untuk menyimpan data GroceryItem.
  final VoidCallback onRemove; // Callback ketika item dihapus dari keranjang.
  final int amount; // Variabel final untuk menyimpan jumlah produk.
  final void Function(GroceryItem item, int quantity) onQuantityChanged; // Callback ketika jumlah produk berubah.

  @override
  _ChartItemWidgetState createState() => _ChartItemWidgetState(); // Membuat state dari ChartItemWidget.
}

class _ChartItemWidgetState extends State<ChartItemWidget> { // State class untuk menangani perubahan state ChartItemWidget.
  final double height = 110; // Tinggi default untuk widget item di keranjang.
  final Color borderColor = Color(0xffE2E2E2); // Warna garis pinggir widget.
  final double borderRadius = 18; // Radius sudut untuk border widget.
  int amount = 1; // Variabel lokal untuk menyimpan jumlah produk.

  @override
  Widget build(BuildContext context) { // Build method untuk mengatur tampilan widget.
    return Container( // Menggunakan Container sebagai wadah utama.
      height: height, // Mengatur tinggi Container sesuai variabel height.
      margin: EdgeInsets.symmetric(vertical: 30), // Margin simetris vertikal 30.
      child: IntrinsicHeight( // Widget IntrinsicHeight untuk mempertahankan tinggi anak-anak.
        child: Row( // Menggunakan Row untuk menyusun konten secara horizontal.
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Menyusun anak-anak dengan ruang di antara mereka.
          crossAxisAlignment: CrossAxisAlignment.stretch, // Anak-anak menyebar dalam hal sumbu silang.
          children: [
            imageWidget(), // Menampilkan gambar produk menggunakan method imageWidget().
            Column( // Column untuk menyusun informasi produk di sebelah kiri gambar.
              crossAxisAlignment: CrossAxisAlignment.start, // Menyusun anak-anak dari kiri ke kanan.
              children: [
                AppText( // Widget kustom AppText untuk menampilkan nama produk.
                  text: widget.item.name, // Menggunakan nama produk dari GroceryItem.
                  fontSize: 16, // Ukuran font 16.
                  fontWeight: FontWeight.bold, // Ketebalan font bold.
                  fontFamily: 'Gilroy', // Font family Gilroy.
                ),
                SizedBox(height: 5), // SizedBox untuk memberikan jarak 5 pixel.
                AppText( // Widget kustom AppText untuk menampilkan deskripsi produk.
                  text: widget.item.description, // Menggunakan deskripsi produk dari GroceryItem.
                  fontSize: 14, // Ukuran font 14.
                  fontWeight: FontWeight.bold, // Ketebalan font semi-bold.
                  color: AppColors.darkGrey, // Warna teks abu-abu gelap dari AppColors.
                  fontFamily: 'Gilroy', // Font family Gilroy.
                ),
                SizedBox(height: 12), // SizedBox untuk memberikan jarak 12 pixel.
                Spacer(), // Spacer untuk memberikan ruang.
                ItemCounterWidget( // Widget ItemCounterWidget untuk menangani perubahan jumlah produk.
                  item: widget.item, // Mengirimkan data produk ke ItemCounterWidget.
                )
              ],
            ),
            Column( // Column untuk menyusun tombol hapus dan harga produk di sebelah kanan.
              children: [
                IconButton( // IconButton untuk tombol hapus item dari keranjang.
                  icon: Icon(Icons.close, color: AppColors.darkGrey, size: 25), // Icon close dengan warna abu-abu gelap.
                  onPressed: widget.onRemove, // Menghubungkan onPressed ke callback onRemove.
                ),
                Spacer(flex: 5), // Spacer untuk memberikan ruang fleksibel.
                Container( // Container untuk harga produk.
                  width: 70, // Lebar Container 70.
                  child: AppText( // Widget kustom AppText untuk menampilkan harga produk.
                    text: "Rp. ${getPrice().toStringAsFixed(0)}", // Mengubah harga menjadi format rupiah.
                    fontSize: 18, // Ukuran font 18.
                    fontWeight: FontWeight.bold, // Ketebalan font bold.
                    textAlign: TextAlign.right, // Teks rata kanan.
                    fontFamily: 'Gilroy', // Font family Gilroy.
                  ),
                ),
                Spacer(), // Spacer untuk memberikan ruang.
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget imageWidget() { // Method untuk menampilkan gambar produk.
    return Container( // Container untuk gambar produk.
      width: 100, // Lebar Container 100.
      child: Image.asset(widget.item.imagePath), // Menampilkan gambar produk dari path yang tersimpan di GroceryItem.
    );
  }

  double getPrice() { // Method untuk menghitung total harga produk.
    return widget.item.price * amount; // Mengalikan harga produk dengan jumlah produk.
  }
}
