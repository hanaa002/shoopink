import 'package:flutter/material.dart';
import 'package:shoopink/models/grocery_item.dart';
import 'package:shoopink/screens/product_details/product_details_screen.dart';
import 'package:shoopink/styles/colors.dart'; // Import file colors.dart untuk warna kustom
import 'package:shoopink/widgets/grocery_item_card_widget.dart';
import 'package:shoopink/widgets/search_bar_widget.dart' as search_bar_widget; // Import search_bar_widget.dart dengan alias
import 'package:intl/intl.dart'; // Import package intl untuk formatting angka
import 'package:shoopink/screens/home/home_banner_widget.dart'; // Import file ini sendiri (tidak diperlukan karena berada di dalamnya)
import 'package:shoopink/screens/home/creator_profile.dart'; // Import file creator_profile.dart untuk profil pengembang
import 'package:shoopink/screens/home/creator_profile_detail.dart'; // Import file creator_profile_detail.dart untuk detail profil pengembang

void main() {
  // Fungsi main untuk menjalankan aplikasi Flutter
  runApp(MaterialApp(
    home: HomeScreen(), // Menetapkan HomeScreen sebagai halaman utama
    theme: ThemeData(
      primaryColor: Colors.green, // Mengatur tema aplikasi dengan primary color green
      fontFamily: 'Gilroy',
    ),
  ));
}

// Kelas HomeScreen sebagai StatelessWidget untuk halaman utama aplikasi
class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // GlobalKey untuk mengakses ScaffoldState

  // Data Profil Pengembang 1
  final CreatorProfile profile1 = CreatorProfile(
    fullName: 'Fidyah Salsabila Putri Sillehu',
    university: 'UPN "Veteran" Jawa Timur',
    faculty: 'Ilmu Komputer',
    major: 'Sistem Informasi',
    npm: '22082010047',
    email: '22082010047@student.upnjatim.ac.id',
    github: 'fidyaahs',
    image: 'assets/images/profilpengembang1.jpg',
  );

  // Data Profil Pengembang 2
  final CreatorProfile profile2 = CreatorProfile(
    fullName: 'Raihana Sakhi Aswanda',
    university: 'UPN "Veteran" Jawa Timur',
    faculty: 'Ilmu Komputer',
    major: 'Sistem Informasi',
    npm: '22082010068',
    email: '22082010068@student.upnjatim.ac.id',
    github: 'hana002',
    image: 'assets/images/profilpengembang2.jpg',
  );

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width; // Lebar layar perangkat

    return Scaffold(
      key: _scaffoldKey, // GlobalKey digunakan untuk akses ScaffoldState
      backgroundColor: Colors.white, // Warna latar belakang putih
      body: SafeArea(
        child: Container(
          color: Colors.white, // Warna latar belakang kontainer putih
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Widget untuk header aplikasi
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Row(
                    children: [
                      // Tombol untuk membuka drawer
                      Builder(
                        builder: (BuildContext context) {
                          return IconButton(
                            icon: Icon(Icons.menu),
                            onPressed: () {
                              _scaffoldKey.currentState?.openDrawer();
                            },
                          );
                        },
                      ),
                      Spacer(), // Spacer untuk memberikan ruang kosong
                      // Logo aplikasi
                      Image.asset(
                        'assets/images/logoshoopink.png',
                        height: 50,
                        width: 50,
                      ),
                      Spacer(), // Spacer lagi untuk ruang kosong
                      // Tombol keranjang belanja (belum diimplementasikan)
                      IconButton(
                        icon: Icon(Icons.notifications),
                        onPressed: () {
                          // Tambahkan aksi ketika ikon keranjang belanja ditekan
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15), // Spacer vertikal dengan ukuran tertentu
                // Widget untuk menampilkan lokasi toko
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: locationWidget(),
                ),
                SizedBox(height: 15), // Spacer vertikal dengan ukuran tertentu
                // Widget untuk kotak pencarian
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: search_bar_widget.SearchBarWidget(),
                ),
                SizedBox(height: 25), // Spacer vertikal dengan ukuran tertentu
                // Widget untuk banner di halaman utama
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: HomeBanner(),
                ),
                SizedBox(height: 25), // Spacer vertikal dengan ukuran tertentu
                // Widget untuk judul "Exclusive Order"
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: subTitle("Exclusive Order"),
                ),
                // Widget untuk slider item horizontal "Exclusive Order"
                getHorizontalItemSlider(screenWidth, exclusiveOffers),
                SizedBox(height: 15), // Spacer vertikal dengan ukuran tertentu
                // Widget untuk judul "Best Selling"
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: subTitle("Best Selling"),
                ),
                // Widget untuk slider item horizontal "Best Selling"
                getHorizontalItemSlider(screenWidth, bestSelling),
                SizedBox(height: 0), // Spacer vertikal dengan ukuran tertentu
                // Widget untuk slider item horizontal "Groceries"
                getHorizontalItemSlider(screenWidth, groceries),
              ],
            ),
          ),
        ),
      ),
      // Widget untuk drawer aplikasi
      drawer: Drawer(
        child: Container(
          color: Colors.white, // Warna latar belakang drawer putih
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: 50, // Tinggi box hijau di atas drawer
                color: const Color.fromARGB(255, 123, 188, 125), // Warna background box hijau
                child: Center(
                  child: Text(
                    'Profil Pengembang', // Judul untuk bagian profil pengembang
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Gilroy', 
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // ListTile untuk menampilkan profil pengembang pertama
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/profilpengembang1.jpg'),
                ),
                title: Text('Fidyah Salsabila', style: TextStyle(fontFamily: 'Gilroy', fontWeight: FontWeight.bold,)), // Ensuring the font is Gilroy
                onTap: () {
                  // Navigasi ke halaman detail profil pengembang pertama
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreatorProfileDetail(profile: profile1)),
                  );
                },
              ),
              // ListTile untuk menampilkan profil pengembang kedua
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/profilpengembang2.jpg'),
                ),
                title: Text('Raihana Sakhi', style: TextStyle(fontFamily: 'Gilroy', fontWeight: FontWeight.bold,)), // Ensuring the font is Gilroy
                onTap: () {
                  // Navigasi ke halaman detail profil pengembang kedua
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreatorProfileDetail(profile: profile2)),
                  );
                },
              ),
              // Tambahkan opsi menu lainnya sesuai kebutuhan di sini
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk menampilkan slider item horizontal
  Widget getHorizontalItemSlider(double screenWidth, List<GroceryItem> items) {
    final double itemWidth = (screenWidth - 60) / 2; // Lebar setiap item dalam slider

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10), // Margin vertikal untuk slider
      height: 250, // Tinggi slider
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: items.length, // Jumlah item dalam slider
        scrollDirection: Axis.horizontal, // Arah scroll horizontal
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onItemClicked(context, items[index]); // Aksi ketika item slider ditekan
            },
            child: SizedBox(
              width: itemWidth,
              child: GroceryItemCardWidget(
                item: items[index],
                heroSuffix: "home_screen",
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 20); // Pembuat pemisah antar item dalam slider
        },
      ),
    );
  }

  // Fungsi untuk menangani aksi saat item dalam slider ditekan
  void onItemClicked(BuildContext context, GroceryItem groceryItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(
          groceryItem,
          heroSuffix: "home_screen",
        ),
      ),
    );
  }

  // Widget untuk menampilkan judul dengan gaya
  // tebal dan memanfaatkan Spacer untuk penempatan teks tambahan di sebelah kanan
  Widget subTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Gilroy',
            ),
          ),
          Spacer(), // Spacer untuk memberikan ruang kosong di sebelah kanan
          Text(
            "", // Teks tambahan yang belum diimplementasikan
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'Gilroy', 
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor), // Pengaturan gaya teks tambahan
          ),
        ],
      ),
    );
  }

  // Widget untuk menampilkan ikon lokasi dan teks nama toko
  Widget locationWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.location_on,
          color: Color.fromARGB(255, 218, 0, 0), // Warna ikon lokasi
        ),
        SizedBox(width: 8), // Spacer horizontal antara ikon dan teks
        Text(
          "Toko Swalayan Aini", // Nama toko
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Gilroy'), // Pengaturan gaya teks
        )
      ],
    );
  }
}

// Fungsi untuk memformat harga ke dalam format mata uang Rupiah
String formatPrice(double price) {
  final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
  return formatter.format(price);
}
