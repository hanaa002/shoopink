import 'package:flutter/material.dart'; // Mengimpor package Flutter untuk membangun UI.
import 'package:intl/intl.dart'; // Mengimpor package untuk formatting angka.
import 'package:provider/provider.dart'; // Mengimpor package untuk state management dengan Provider.
import 'package:shoopink/providers/cart_provider.dart'; // Mengimpor provider CartProvider untuk mengelola data keranjang.
import 'package:shoopink/common_widgets/app_button.dart'; // Mengimpor widget tombol aplikasi kustom.
import 'package:shoopink/helpers/column_with_seprator.dart'; // Mengimpor helper untuk menambahkan separator antar widget.
import 'package:shoopink/widgets/chart_item_widget.dart'; // Mengimpor widget untuk item dalam keranjang.
import 'checkout_bottom_sheet.dart'; // Mengimpor bottom sheet untuk proses checkout.
import 'package:shoopink/screens/dashboard/dashboard_screen.dart'; // Mengimpor layar dashboard aplikasi.

class CartScreen extends StatefulWidget { // Mendefinisikan kelas CartScreen sebagai StatefulWidget.
  @override
  _CartScreenState createState() => _CartScreenState(); // Membuat state untuk CartScreen.
}

class _CartScreenState extends State<CartScreen> { // Mendefinisikan state untuk CartScreen.
  double totalPrice = 0; // Variabel untuk menyimpan total harga.

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Scaffold adalah struktur dasar dari halaman.
      backgroundColor: Colors.white, // Mengatur warna latar belakang Scaffold menjadi putih.
      appBar: AppBar( // Membuat AppBar di atas halaman.
        backgroundColor: Colors.transparent, // Mengatur latar belakang AppBar menjadi transparan.
        elevation: 0, // Menghapus bayangan (elevation) AppBar.
        leading: IconButton( // Tombol di kiri atas AppBar.
          icon: Icon(Icons.arrow_back_ios, color: Colors.black), // Ikon panah kembali berwarna hitam.
          onPressed: () { // Fungsi ketika tombol ditekan.
            Navigator.pushReplacement( // Navigasi ke layar dashboard.
              context,
              MaterialPageRoute(builder: (context) => DashboardScreen()),
            );
          },
        ),
        title: Text(
          "Keranjang", // Judul AppBar.
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontFamily: 'Gilroy',), // Mengatur gaya teks judul.
        ),
        centerTitle: true, // Menengahkan judul.
      ),
      body: SafeArea( // SafeArea memastikan konten tidak terpotong oleh status bar atau notch.
        child: SingleChildScrollView( // Membuat halaman bisa di-scroll.
          child: Column(
            children: [
              SizedBox(height: 20), // Memberikan jarak setinggi 20 piksel.
              Consumer<CartProvider>( // Menggunakan Consumer untuk mendengarkan perubahan pada CartProvider.
                builder: (context, cartProvider, child) {
                  return Column(
                    children: getChildrenWithSeperator( // Menggunakan helper untuk menambahkan separator antar item.
                      addToLastChild: false,
                      widgets: cartProvider.cartItems.map((e) { // Memetakan setiap item dalam cartItems ke widget ChartItemWidget.
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 25), // Memberikan padding horizontal.
                          width: double.maxFinite, // Mengatur lebar kontainer maksimal.
                          child: ChartItemWidget(
                            item: e, // Mengirim item ke widget.
                            onRemove: () { // Fungsi ketika item dihapus.
                              cartProvider.removeItem(e); // Menghapus item dari keranjang.
                            },
                            onQuantityChanged: (item, quantity) { // Fungsi ketika jumlah item diubah.
                              setState(() {
                                cartProvider.updateItemQuantity(item, quantity); // Memperbarui jumlah item.
                              });
                            },
                            amount: 0, // Mengatur jumlah default.
                          ),
                        );
                      }).toList(),
                      seperator: Padding( // Separator antara item.
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Divider(thickness: 1), // Divider dengan ketebalan 1.
                      ),
                    ),
                  );
                },
              ),
              Divider(thickness: 1), // Divider di bawah daftar item.
              getCheckoutButton(context), // Memanggil fungsi untuk mendapatkan tombol checkout.
            ],
          ),
        ),
      ),
    );
  }

  Widget getCheckoutButton(BuildContext context) {
    return Consumer<CartProvider>( // Menggunakan Consumer untuk mendengarkan perubahan pada CartProvider.
      builder: (context, cartProvider, child) {
        totalPrice = cartProvider.cartItems.fold(0, (sum, item) => sum + (item.price * item.amount)); // Menghitung total harga.
        return Visibility(
          visible: true, // Menampilkan tombol checkout jika keranjang tidak kosong.
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25), // Memberikan padding horizontal.
            child: AppButton(
              label: "Checkout", // Label tombol checkout.
              padding: EdgeInsets.symmetric(vertical: 25), // Memberikan padding vertikal.
              color: Color.fromARGB(255, 0, 218, 94), // Warna tombol.
              textColor: Colors.white, // Warna teks tombol.
              onPressed: () { // Fungsi ketika tombol checkout ditekan.
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true, // Membuat bottom sheet dapat di-scroll.
                  builder: (context) => CheckoutBottomSheet(totalPrice: totalPrice), // Menampilkan bottom sheet untuk checkout.
                );
              },
            ),
          ),
        );
      },
    );
  }
}