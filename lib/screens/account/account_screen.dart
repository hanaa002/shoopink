// Import Flutter dan Firebase packages yang diperlukan
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Import beberapa file lokal
import 'package:shoopink/common_widgets/app_text.dart';
import 'package:shoopink/screens/welcome_screen.dart';
import 'package:shoopink/styles/colors.dart';
import 'package:shoopink/orders_db.dart'; // Import kelas OrdersDB

// Import account_item.dart yang diperlukan untuk menampilkan item akun
import 'account_item.dart';

// Class AccountScreen adalah stateless widget
class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Mendapatkan user yang sedang login menggunakan FirebaseAuth
    User? user = FirebaseAuth.instance.currentUser;

    // Memulai dengan SafeArea untuk menghindari notch dan area yang aman
    return SafeArea(
      child: Container(
        color: Colors.white,
        // Menggunakan SingleChildScrollView untuk mengizinkan scrolling jika konten lebih panjang
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20), // Spacer
              
              // Informasi user (avatar, nama, email)
              ListTile(
                leading: SizedBox(
                  width: 65,
                  height: 65,
                  child: getImageHeader(), // Mendapatkan avatar user
                ),
                title: AppText(
                  text: 'Hi! ${user?.displayName ?? ""}', // Menampilkan nama user
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Gilroy', // Ganti font menjadi Gilroy
                ),
                subtitle: AppText(
                  text: user?.email ?? "", // Menampilkan email user
                  color: Color(0xff7C7C7C),
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  fontFamily: 'Gilroy', // Ganti font menjadi Gilroy
                ),
              ),
              
              // Menampilkan item akun seperti Orders, menggunakan getAccountItemWidget
              Column(
                children: getChildrenWithSeparator(
                  widgets: accountItems.map((e) {
                    return getAccountItemWidget(e, context, user); // Menyediakan item akun untuk ditampilkan
                  }).toList(),
                  separator: Divider(thickness: 1), // Pemisah antar item
                ),
              ),
              
              SizedBox(height: 20), // Spacer
              
              // Tombol logout
              logoutButton(context), // Menggunakan fungsi logoutButton untuk menampilkan tombol logout
              
              SizedBox(height: 20) // Spacer
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk tombol logout
  Widget logoutButton(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          visualDensity: VisualDensity.compact,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          elevation: 0,
          backgroundColor: Color(0xffF2F3F2),
          textStyle: TextStyle(color: Colors.white),
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 25),
          minimumSize: const Size.fromHeight(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.logout, color: Colors.black, size: 20), // Icon logout
            Text(
              "Log Out", // Teks pada tombol logout
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
                fontFamily: 'Gilroy', // Ganti font menjadi Gilroy
              ),
            ),
            Container()
          ],
        ),
        onPressed: () async {
          await FirebaseAuth.instance.signOut(); // Proses sign out dari FirebaseAuth
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) {
              return WelcomeScreen(); // Navigasi ke halaman welcome setelah logout
            },
          ));
        },
      ),
    );
  }

  // Widget untuk mendapatkan header avatar user
  Widget getImageHeader() {
    String imagePath = "assets/images/account_image.jpg"; // Path gambar avatar user
    return CircleAvatar(
      radius: 5.0,
      backgroundImage: AssetImage(imagePath), // Menggunakan gambar avatar
      backgroundColor: AppColors.primaryColor.withOpacity(0.7), // Warna latar belakang avatar
    );
  }

  // Widget untuk mendapatkan widget item akun
  Widget getAccountItemWidget(AccountItem accountItem, BuildContext context, User? user) {
    // Jika item adalah Orders, tampilkan daftar pesanan dari OrdersDB
    if (accountItem.label == "Orders") {
      return FutureBuilder<List<Map<String, dynamic>>>(
        future: OrdersDB().getOrdersListForUser(user!.uid), // Mendapatkan daftar pesanan untuk user yang sedang login
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Tampilkan indikator loading saat data sedang dimuat
          } else {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}'); // Tampilkan pesan error jika terjadi kesalahan
            } else {
              List<Map<String, dynamic>> orders = snapshot.data ?? []; // Mendapatkan data pesanan
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrdersScreen(orders: orders), // Navigasi ke halaman OrdersScreen dengan membawa data pesanan
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Icon(accountItem.icon, color: Colors.black, size: 20), // Icon untuk item akun
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            accountItem.label, // Label item akun (Orders)
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Gilroy'), // Ganti font menjadi Gilroy
                          ),
                          Text(
                            '${orders.length} Orders', // Jumlah pesanan
                            style: TextStyle(fontSize: 16, color: Colors.grey, fontFamily: 'Gilroy'), // Ganti font menjadi Gilroy
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios) // Icon untuk navigasi
                    ],
                  ),
                ),
              );
            }
          }
        },
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          children: [
            Icon(accountItem.icon, color: Colors.black, size: 20), // Icon untuk item akun
            SizedBox(width: 20),
            Text(
              accountItem.label, // Label item akun
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Gilroy'), // Ganti font menjadi Gilroy
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios) // Icon untuk navigasi
          ],
        ),
      );
    }
  }

  // Fungsi untuk mendapatkan list widget dengan separator di antara mereka
  List<Widget> getChildrenWithSeparator({
    required List<Widget> widgets,
    required Widget separator,
  }) {
    if (widgets.isEmpty) return []; // Jika tidak ada widget, kembalikan list kosong
    final List<Widget> separatedWidgets = [];
    for (int i = 0; i < widgets.length; i++) {
      separatedWidgets.add(widgets[i]); // Tambahkan widget ke list
      if (i != widgets.length - 1) {
        separatedWidgets.add(separator); // Tambahkan separator di antara widget
      }
    }
    return separatedWidgets; // Kembalikan list widget dengan separator
  }
}

// Class OrdersScreen untuk menampilkan daftar pesanan
class OrdersScreen extends StatelessWidget {
  final List<Map<String, dynamic>> orders; // Daftar pesanan yang akan ditampilkan

  OrdersScreen({required this.orders}); // Constructor untuk OrdersScreen

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders', style: TextStyle(fontFamily: 'Gilroy')), // Judul halaman Orders dengan font Gilroy
      ),
      body: orders.isEmpty
          ? Center(
              child: Text('No orders found.', style: TextStyle(fontFamily: 'Gilroy')), // Pesan jika tidak ada pesanan dengan font Gilroy
            )
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Order ID: ${orders[index]['orderId']}', style: TextStyle(fontFamily: 'Gilroy')), // Menampilkan ID pesanan dengan font Gilroy
                  subtitle: Text('Total: ${orders[index]['total_pembayaran']}', style: TextStyle(fontFamily: 'Gilroy')), // Menampilkan total pembayaran dengan font Gilroy
                  // Add more details as needed
                );
              },
            ),
    );
  }
}
