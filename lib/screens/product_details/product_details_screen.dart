import 'package:flutter/material.dart'; // Mengimpor package flutter/material.dart untuk menggunakan Flutter UI framework.
import 'package:provider/provider.dart'; // Mengimpor package provider.dart untuk menggunakan state management dengan Provider.
import 'package:shoopink/providers/cart_provider.dart'; // Mengimpor CartProvider untuk mengelola keranjang belanja.
import 'package:shoopink/models/grocery_item.dart'; // Mengimpor model GroceryItem untuk data produk.
import 'package:shoopink/screens/cart/cart_screen.dart'; // Mengimpor layar CartScreen untuk navigasi ke keranjang.
import 'package:shoopink/widgets/item_counter_widget.dart'; // Mengimpor widget ItemCounterWidget untuk menghitung jumlah item.
import 'package:shoopink/common_widgets/app_button.dart'; // Mengimpor widget AppButton untuk tombol aplikasi.
import 'package:shoopink/common_widgets/app_text.dart'; // Mengimpor widget AppText untuk teks aplikasi.
import 'package:intl/intl.dart'; // Mengimpor package intl.dart untuk format angka.
import 'package:shoopink/screens/dashboard/dashboard_screen.dart'; // Mengimpor layar DashboardScreen untuk navigasi kembali ke dashboard.

class ProductDetailsScreen extends StatefulWidget { // Deklarasi class ProductDetailsScreen sebagai StatefulWidget.
  final GroceryItem groceryItem; // Variabel untuk menyimpan data GroceryItem.
  final String? heroSuffix; // Suffix untuk hero animation jika diberikan.

  const ProductDetailsScreen(this.groceryItem, {this.heroSuffix}); // Constructor untuk menerima GroceryItem dan heroSuffix opsional.

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState(); // Override method untuk membuat state ProductDetailsScreen.
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> { // Deklarasi class _ProductDetailsScreenState sebagai state dari ProductDetailsScreen.
  int amount = 1; // Variabel untuk menyimpan jumlah produk yang akan ditambahkan ke keranjang.

  @override
  Widget build(BuildContext context) { // Method build untuk membangun tampilan widget.
    return Scaffold( // Menggunakan Scaffold sebagai kerangka utama halaman.
      backgroundColor: Colors.white, // Warna latar belakang Scaffold.
      appBar: AppBar( // AppBar di bagian atas halaman.
        backgroundColor: Colors.transparent, // Warna latar belakang AppBar transparan.
        elevation: 0, // Menghilangkan bayangan di bawah AppBar.
        leading: IconButton( // IconButton sebagai tombol kembali.
          icon: Icon(Icons.arrow_back_ios, color: Colors.black), // Icon tombol kembali dengan warna hitam.
          onPressed: () { // Aksi ketika tombol kembali ditekan.
            Navigator.pushReplacement( // Menggunakan Navigator untuk navigasi dengan mengganti halaman.
              context,
              MaterialPageRoute(builder: (context) => DashboardScreen()), // Navigasi kembali ke DashboardScreen.
            );
          },
        ),
        title: Text( // Judul AppBar.
          'Produk Detail', // Teks judul.
          style: TextStyle(color: Colors.black, fontFamily: 'Gilroy', fontWeight: FontWeight.bold), // Style teks judul dengan warna hitam.
        ),
        centerTitle: true, // Menyusun judul AppBar di tengah.
      ),
      body: SafeArea( // Menggunakan SafeArea untuk memastikan tampilan aman di area perangkat.
        child: SingleChildScrollView( // SingleChildScrollView untuk mengizinkan scroll jika konten lebih panjang dari layar.
          child: Column( // Column untuk menyusun widget secara vertikal.
            children: [
              getImageHeaderWidget(), // Widget untuk header gambar produk.
              Padding( // Padding untuk memberikan jarak dari tepi.
                padding: const EdgeInsets.symmetric(horizontal: 25), // Padding horizontal 25.
                child: Column( // Column untuk menyusun konten produk.
                  children: [
                    ListTile( // ListTile untuk judul dan deskripsi produk.
                      contentPadding: EdgeInsets.zero, // Padding konten ListTile diatur ke nol.
                      title: Text( // Judul produk.
                        widget.groceryItem.name, // Teks judul dari GroceryItem.
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Gilroy'), // Style untuk teks judul dengan font Gilroy.
                      ),
                      subtitle: AppText( // Subtitle untuk deskripsi produk.
                        text: widget.groceryItem.description, // Teks deskripsi dari GroceryItem.
                        fontSize: 16, // Ukuran teks deskripsi.
                        fontWeight: FontWeight.w600, // Ketebalan teks deskripsi.
                        color: Color(0xff7C7C7C), // Warna teks deskripsi.
                        fontFamily: 'Gilroy', // Font Gilroy untuk teks deskripsi.
                      ),
                    ),
                    Row( // Row untuk menampilkan counter item dan harga total.
                      children: [
                        ItemCounterWidget( // Widget ItemCounterWidget untuk mengatur jumlah item.
                          item: widget.groceryItem, // Mengirimkan data produk ke ItemCounterWidget.
                          onAmountChanged: (item, quantity) { // Aksi ketika jumlah produk berubah.
                            final cartProvider = Provider.of<CartProvider>(context, listen: false); // Mengakses CartProvider dari Provider.
                            setState(() { // Memanggil setState untuk mengubah state jumlah produk.
                              cartProvider.updateItemQuantity(item, quantity); // Memperbarui jumlah produk di keranjang.
                            });
                          },
                        ),
                        Spacer(), // Spacer untuk memberikan ruang antara widget.
                        Text( // Widget untuk menampilkan harga total.
                          "Rp${NumberFormat("#,##0", "id_ID").format(getTotalPrice())}", // Mengubah format harga menjadi rupiah.
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Gilroy'), // Style untuk teks harga total dengan font Gilroy.
                        )
                      ],
                    ),
                    Divider(thickness: 1), // Divider untuk memisahkan bagian produk.
                    getProductDataRowWidget("Detail Produk"), // Widget untuk baris detail produk.
                    Divider(thickness: 1), // Divider untuk memisahkan bagian produk.
                    getProductDataRowWidget("Nutrisi", // Widget untuk baris nutrisi produk.
                        customWidget: nutritionWidget()), // Widget kustom untuk konten nutrisi.
                    Divider(thickness: 1), // Divider untuk memisahkan bagian produk.
                    getProductDataRowWidget( // Widget untuk baris ulasan produk.
                      "Ulasan",
                      customWidget: ratingWidget(), // Widget kustom untuk konten ulasan.
                    ),
                    SizedBox(height: 20), // Spasi sebelum tombol.
                    AppButton( // Tombol untuk menambahkan produk ke keranjang.
                      label: "Masukkan Keranjang", // Teks label tombol.
                      onPressed: () { // Aksi ketika tombol ditekan.
                        final cartProvider = Provider.of<CartProvider>(context, listen: false); // Mengakses CartProvider dari Provider.
                        for (int i = 0; i < amount; i++) { // Loop untuk menambahkan produk sesuai jumlah yang dipilih.
                          cartProvider.addItem(widget.groceryItem); // Menambahkan produk ke dalam keranjang.
                        }
                        showDialog( // Menampilkan dialog konfirmasi.
                          context: context,
                          builder: (context) => AlertDialog( // AlertDialog sebagai konten dialog.
                            title: Text('Sukses', style: TextStyle(fontFamily: 'Gilroy')), // Judul dialog dengan font Gilroy.
                            content: Text('Item telah ditambahkan ke keranjang.', style: TextStyle(fontFamily: 'Gilroy')), // Isi konten dialog dengan font Gilroy.
                            actions: [
                              TextButton( // Tombol dalam dialog.
                                onPressed: () {
                                  Navigator.of(context).pop(); // Menutup dialog.
                                  Navigator.of(context).push( // Navigasi ke halaman keranjang.
                                    MaterialPageRoute(
                                      builder: (context) => CartScreen(),
                                    ),
                                  ); // Navigasi ke CartScreen.
                                },
                                child: Text('Pergi ke Keranjang', style: TextStyle(fontFamily: 'Gilroy')), // Teks tombol dengan font Gilroy.
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20), // Spasi setelah tombol.
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageHeaderWidget() { // Widget untuk header gambar produk.
    return Container( // Menggunakan Container untuk header.
      height: 250, // Tinggi Container.
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25), // Padding horizontal dan vertical.
      width: double.maxFinite, // Lebar Container mengikuti lebar maksimum.
      decoration: BoxDecoration( // Dekorasi untuk latar belakang Container.
        color: const Color.fromARGB(255, 255, 255, 255), // Warna latar belakang Container.
        borderRadius: BorderRadius.only( // BorderRadius untuk sudut Container.
          bottomLeft: Radius.circular(25), // Sudut bawah kiri.
          bottomRight: Radius.circular(25), // Sudut bawah kanan.
        ),
        gradient: LinearGradient( // Gradasi linear untuk latar belakang.
            colors: [
              Color.fromARGB(255, 255, 255, 255).withOpacity(0.1), // Warna awal gradasi dengan opacity 0.1.
              Color.fromARGB(255, 255, 255, 255).withOpacity(0.09), // Warna akhir gradasi dengan opacity 0.09.
            ],
            begin: const FractionalOffset(0.0, 0.0), // Titik awal gradasi.
            end: const FractionalOffset(0.0, 1.0), // Titik akhir gradasi.
            stops: [0.0, 1.0], // Posisi warna dalam gradasi.
            tileMode: TileMode.clamp),
      ),
      child: Hero( // Hero widget untuk animasi transisi.
        tag: "GroceryItem:" + widget.groceryItem.name + "-" + (widget.heroSuffix ?? ""), // Tag Hero untuk animasi.
        child: Image( // Gambar produk.
          image: AssetImage(widget.groceryItem.imagePath), // Mengambil gambar dari asset.
        ),
      ),
    );
  }

  Widget getProductDataRowWidget(String label, {Widget? customWidget}) { // Widget untuk baris data produk.
    return Container( // Menggunakan Container untuk baris data.
      margin: EdgeInsets.only( // Margin di sekitar Container.
        top: 20,
        bottom: 20,
      ),
      child: Row( // Row untuk menyusun widget secara horizontal.
        children: [
          AppText(
            text: label,
            fontWeight: FontWeight.w600,
            fontSize: 16,
            fontFamily: 'Gilroy', // Teks label dengan font Gilroy.
          ),
          Spacer(), // Spacer untuk memberikan ruang antara widget.
          if (customWidget != null) ...[ // Jika ada widget kustom, tampilkan.
            customWidget,
            SizedBox(
              width: 20,
            )
          ],
          Icon( // Icon panah untuk navigasi.
            Icons.arrow_forward_ios,
            size: 20,
          )
        ],
      ),
    );
  }

  Widget nutritionWidget() { // Widget untuk informasi nutrisi.
    return Container( // Menggunakan Container untuk informasi nutrisi.
      padding: EdgeInsets.all(5), // Padding di dalam Container.
      decoration: BoxDecoration( // Dekorasi untuk latar belakang Container.
        color: Color(0xffEBEBEB), // Warna latar belakang.
        borderRadius: BorderRadius.circular(5), // BorderRadius untuk sudut Container.
      ),
      child: AppText(
        text: "100gm", // Teks informasi nutrisi.
        fontWeight: FontWeight.w600, // Ketebalan teks.
        fontSize: 12, // Ukuran teks.
        color: Color(0xff7C7C7C), // Warna teks.
        fontFamily: 'Gilroy', // Font Gilroy untuk teks.
      ),
    );
  }

  Widget ratingWidget() { // Widget untuk rating ulasan produk.
    Widget starIcon() { // Widget untuk icon bintang.
      return Icon(
        Icons.star,
        color: Color(0xffF3603F), // Warna icon bintang.
        size: 20, // Ukuran icon bintang.
      );
    }

    return Row( // Row untuk menyusun icon bintang secara horizontal.
      children: [
        starIcon(), // Icon bintang.
        starIcon(), // Icon bintang.
        starIcon(), // Icon bintang.
        starIcon(), // Icon bintang.
        starIcon(), // Icon bintang.
      ],
    );
  }

  double getTotalPrice() { // Fungsi untuk menghitung total harga.
    return amount * widget.groceryItem.price; // Mengalikan jumlah produk dengan harga satuan.
  }
}
