import 'package:flutter/material.dart'; // Mengimpor package flutter/material.dart untuk menggunakan Flutter UI framework.
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart'; // Mengimpor package flutter_staggered_grid_view.dart untuk menggunakan StaggeredGridView.
import 'package:shoopink/common_widgets/app_text.dart'; // Mengimpor widget AppText dari direktori common_widgets/app_text.dart.
import 'package:shoopink/models/grocery_item.dart'; // Mengimpor model GroceryItem dari direktori models/grocery_item.dart.
import 'package:shoopink/screens/product_details/product_details_screen.dart'; // Mengimpor screen ProductDetailsScreen dari direktori screens/product_details/product_details_screen.dart.
import 'package:shoopink/widgets/grocery_item_card_widget.dart'; // Mengimpor widget GroceryItemCardWidget dari direktori widgets/grocery_item_card_widget.dart.

class CategoryItemsScreen extends StatefulWidget { // Deklarasi class CategoryItemsScreen sebagai StatefulWidget.
  @override
  _CategoryItemsScreenState createState() => _CategoryItemsScreenState(); // Membuat state untuk CategoryItemsScreen.
}

class _CategoryItemsScreenState extends State<CategoryItemsScreen> { // Deklarasi class _CategoryItemsScreenState sebagai state untuk CategoryItemsScreen.
  List<GroceryItem> _filteredItems = beverages; // Inisialisasi _filteredItems dengan daftar beverages.

  void _searchItems(String query) { // Method untuk melakukan pencarian item berdasarkan query.
    final filteredItems = beverages.where((item) { // Filtering item dari daftar beverages.
      final itemNameLower = item.name.toLowerCase(); // Mendapatkan nama item dalam huruf kecil.
      final searchLower = query.toLowerCase(); // Mengubah query menjadi huruf kecil.

      return itemNameLower.contains(searchLower); // Mengembalikan true jika nama item mengandung query.
    }).toList();

    setState(() { // Memperbarui state _filteredItems dengan hasil pencarian.
      _filteredItems = filteredItems;
    });
  }

  @override
  Widget build(BuildContext context) { // Method untuk membangun tampilan CategoryItemsScreen.
    return Scaffold( // Menggunakan Scaffold sebagai layout utama.
      backgroundColor: Colors.white, // Mengatur warna latar belakang Scaffold menjadi putih.
      appBar: AppBar( // Membangun AppBar.
        backgroundColor: Colors.transparent, // Mengatur latar belakang AppBar menjadi transparan.
        elevation: 0, // Menghilangkan bayangan di AppBar.
        centerTitle: true, // Memposisikan judul AppBar di tengah.
        automaticallyImplyLeading: false, // Menghilangkan tombol back di AppBar.
        leading: GestureDetector( // Menambahkan GestureDetector untuk handling ketika tombol back diklik.
          onTap: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya.
          },
          child: Container(
            padding: EdgeInsets.only(left: 25),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          // Menambahkan actions di AppBar (jika ada).
        ],
        title: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: AppText(
            text: "Minuman", // Menampilkan teks "Minuman" sebagai judul AppBar.
            fontWeight: FontWeight.bold, // Mengatur ketebalan teks judul AppBar.
            fontSize: 20, // Mengatur ukuran teks judul AppBar.
            fontFamily: 'Gilroy',
          ),
        ),
      ),
      body: Column( // Membangun body dengan menggunakan Column sebagai parent widget.
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField( // Menambahkan TextField untuk pencarian.
              onChanged: _searchItems, // Menghubungkan method _searchItems dengan onChanged TextField.
              decoration: InputDecoration( // Mengatur dekorasi TextField.
                prefixIcon: Icon(Icons.search), // Menambahkan ikon search di sebelah kiri TextField.
                hintText: "Cari", // Memberikan hint text pada TextField.
                hintStyle: TextStyle(fontFamily: 'Gilroy'),
                border: OutlineInputBorder( // Mengatur border untuk TextField.
                  borderRadius: BorderRadius.circular(10), // Mengatur borderRadius border.
                  borderSide: BorderSide.none, // Menghilangkan borderSide untuk border.
                ),
                filled: true, // Mengatur TextField menjadi terisi dengan warna latar belakang.
                fillColor: Colors.grey[200], // Memberikan warna latar belakang TextField.
                contentPadding: EdgeInsets.zero, // Mengatur padding content TextField.
              ),
              style: TextStyle(fontFamily: 'Gilroy'),
            ),
          ),
          Expanded( // Menggunakan Expanded untuk mengisi ruang kosong yang tersedia.
            child: SingleChildScrollView( // Menggunakan SingleChildScrollView untuk mengatasi overflow.
              child: StaggeredGrid.count( // Menggunakan StaggeredGrid untuk menampilkan item dalam grid yang bersusun.
                crossAxisCount: 2, // Menentukan jumlah item per baris.
                children: _filteredItems.asMap().entries.map<Widget>((e) { // Mapping _filteredItems menjadi widget-widget.
                  GroceryItem groceryItem = e.value; // Mengambil GroceryItem dari _filteredItems.
                  return GestureDetector( // Menambahkan GestureDetector untuk menangani ketika item di-klik.
                    onTap: () {
                      onItemClicked(context, groceryItem); // Memanggil method onItemClicked ketika item di-klik.
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: GroceryItemCardWidget( // Menampilkan widget GroceryItemCardWidget untuk setiap item.
                        item: groceryItem, // Mengirimkan data GroceryItem ke GroceryItemCardWidget.
                        heroSuffix: "explore_screen", // Menentukan heroSuffix untuk animasi hero.
                      ),
                    ),
                  );
                }).toList(),
                mainAxisSpacing: 3.0, // Memberikan spasi antar item secara vertikal.
                crossAxisSpacing: 0.0, // Memberikan sedikit spasi antar item secara horizontal.
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onItemClicked(BuildContext context, GroceryItem groceryItem) { // Method untuk menangani ketika item di-klik.
    Navigator.push( // Navigasi ke halaman ProductDetailsScreen ketika item di-klik.
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(
          groceryItem, // Mengirim data GroceryItem ke ProductDetailsScreen.
          heroSuffix: "explore_screen", // Menentukan heroSuffix untuk animasi hero.
        ),
      ),
    );
  }
}
