import 'package:flutter/material.dart'; // Import dasar dari Flutter framework
import 'package:http/http.dart' as http; // Import HTTP client untuk komunikasi dengan API
import 'dart:convert'; // Import library untuk mengolah JSON
import 'package:intl/intl.dart'; // Import library untuk formatting angka
import 'package:shared_preferences/shared_preferences.dart'; // Import untuk mengakses shared preferences
import 'package:shoopink/orders_db.dart'; // Import class OrdersDB untuk mengakses database order
import 'kota.dart'; // Import model Kota
import '/common_widgets/app_button.dart'; // Import widget tombol aplikasi
import '../order_accepted_screen.dart'; // Import layar notifikasi pesanan diterima
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore untuk menyimpan data
import 'package:provider/provider.dart'; // Import provider untuk manajemen state
import 'package:shoopink/providers/cart_provider.dart'; // Import provider keranjang belanja

class CheckoutBottomSheet extends StatefulWidget { // Deklarasi kelas CheckoutBottomSheet sebagai StatefulWidget
  final double totalPrice; // Properti untuk total harga pesanan

  CheckoutBottomSheet({required this.totalPrice}); // Konstruktor dengan parameter wajib totalPrice

  @override
  _CheckoutBottomSheetState createState() => _CheckoutBottomSheetState(); // Override createState untuk membuat instance dari _CheckoutBottomSheetState
}

class _CheckoutBottomSheetState extends State<CheckoutBottomSheet> {
  String selectedStoreAddress = ""; // Alamat toko yang dipilih
  String selectedStoreAddressId = ""; // ID alamat toko yang dipilih
  late String? surabayaCityId; // ID Kota Surabaya
  Kota? selectedHomeAddress; // Alamat rumah yang dipilih
  String selectedCourier = ""; // Kurir pengiriman yang dipilih
  String selectedPaymentMethod = ""; // Metode pembayaran yang dipilih
  String accountNumber = ""; // Nomor rekening untuk pembayaran
  List<Kota> cities = []; // Daftar kota
  List<Map<String, dynamic>> shippingOptions = []; // Opsi pengiriman
  double shippingCost = 0.0; // Biaya pengiriman
  double totalCost = 0.0; // Total biaya
  String detailedAddress = ""; // Detail alamat rumah
  OrdersDB ordersDB =
      OrdersDB(); // Instance dari OrdersDB untuk mengakses database order

  @override
  void initState() { // Override initState untuk melakukan inisialisasi state
    super.initState();
    fetchCities(); // Panggil fungsi fetchCities untuk mengambil daftar kota
    fetchCitiesStore(); // Panggil fungsi fetchCitiesStore untuk mengambil daftar kota toko dan mengatur alamat toko default
    fetchCitiesStore().then((_) { // Setelah mengambil daftar kota toko, set alamat toko default dan panggil fetchShippingOptions
      setState(() {
        selectedStoreAddress = "Jl. Medokan Asri Barat (Surabaya)";
        selectedStoreAddressId = surabayaCityId!;
      });
      fetchShippingOptions(); // Memuat opsi pengiriman setelah memilih alamat toko
    });
  }

  // Mengambil daftar kota dari API RajaOngkir
  Future<void> fetchCities() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.rajaongkir.com/starter/city?key=df3f44489979c6bd45c8bafd2e9d74db'),
      );

      if (response.statusCode == 200) { // Jika permintaan berhasil, dekode response dan update state cities
        final data = json.decode(response.body);
        setState(() {
          cities = Kota.fromJsonList(data['rajaongkir']['results']);
        });
      } else {
        print('Request failed with status: ${response.statusCode}'); // Cetak pesan error jika permintaan gagal
      }
    } catch (e) {
      print('Error occurred: $e'); // Tangkap dan cetak error yang terjadi
    }
  }

  // Mengambil daftar kota dari API RajaOngkir dan mengatur alamat toko default (Surabaya)
  Future<void> fetchCitiesStore() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.rajaongkir.com/starter/city?key=df3f44489979c6bd45c8bafd2e9d74db'),
      );

      if (response.statusCode == 200) { // Jika permintaan berhasil, dekode response dan update state cities serta set surabayaCityId
        final data = json.decode(response.body);
        setState(() {
          cities = Kota.fromJsonList(data['rajaongkir']['results']);
          final surabaya = cities.firstWhere((city) => city.cityName!.contains('Surabaya'));
          surabayaCityId = surabaya.cityId!;
        });
      } else {
        print('Request failed with status: ${response.statusCode}'); // Cetak pesan error jika permintaan gagal
      }
    } catch (e) {
      print('Error occurred: $e'); // Tangkap dan cetak error yang terjadi
    }
  }

  // Mengambil opsi pengiriman dari API RajaOngkir berdasarkan alamat rumah, kurir, dan berat
  Future<void> fetchShippingOptions() async {
    if (selectedHomeAddress == null || selectedCourier.isEmpty) { // Jika alamat rumah atau kurir kosong, keluar dari fungsi
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('https://api.rajaongkir.com/starter/cost'),
        headers: {
          'key': 'df3f44489979c6bd45c8bafd2e9d74db',
          'content-type': 'application/x-www-form-urlencoded'
        },
        body: {
          'origin': selectedStoreAddressId,
          'destination': selectedHomeAddress!.cityId!,
          'weight': '1000', // Contoh berat (dalam gram)
          'courier': selectedCourier,
        },
      );

      if (response.statusCode == 200) { // Jika permintaan berhasil, dekode response dan update state shippingOptions, shippingCost, dan totalCost
        final data = json.decode(response.body);
        setState(() {
          shippingOptions = List<Map<String, dynamic>>.from(data['rajaongkir']['results'][0]['costs']);
          if (shippingOptions.isNotEmpty) {
            shippingCost = double.parse(shippingOptions[0]['cost'][0]['value'].toString());
            totalCost = widget.totalPrice + shippingCost;
          }
        });
      } else {
        print('Request failed with status: ${response.statusCode}'); // Cetak pesan error jika permintaan gagal
      }
    } catch (e) {
      print('Error occurred: $e'); // Tangkap dan cetak error yang terjadi
    }
  }

  // Menempatkan pesanan dengan menyiapkan data pesanan dan menyimpannya di Firestore
  Future<void> placeOrder() async {
    try {
      var cartProvider = Provider.of<CartProvider>(context, listen: false);

      // Mendapatkan daftar barang dari keranjang
      List<Map<String, dynamic>> items = cartProvider.cartItems.map((item) {
        return {
          'nama_barang': item.name,
          'quantity': item.amount,
        };
      }).toList();

      // Mengambil ID pengguna dari shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');

      // Menyiapkan data pesanan
      Map<String, dynamic> orderData = {
        'userId': userId,
        'items': items,
        'alamat_rumah': "${selectedHomeAddress!.cityName}, $detailedAddress",
        'ekspedisi': selectedCourier,
        'metode_pembayaran': selectedPaymentMethod,
        'harga': widget.totalPrice,
        'ongkir': shippingCost,
        'total_pembayaran': totalCost,
      };

      // Menambahkan pesanan ke Firestore menggunakan instance ordersDB
      await ordersDB.addOrder(orderData);

      // Mengosongkan keranjang belanja
      cartProvider.clearCart();

      Navigator.pop(context); // Menutup bottom sheet checkout
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return OrderAcceptedScreen(); // Menampilkan dialog pesanan diterima
        },
      );
    } catch (e) {
      print("Error placing order: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Wrap(
          children: <Widget>[
            Row(
              children: [
                Text(
                  "Checkout",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, fontFamily: 'Gilroy'),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close, size: 25),
                ),
              ],
            ),
            SizedBox(height: 45),
            getDivider(), // Memuat divider
            dropdownSearch(
              "Alamat Toko",
              items: ["Jl. Medokan Asri Barat (Surabaya)"],
              onChanged: (String? newValue) {
                setState(() {
                  selectedStoreAddress = "Jl. Medokan Asri Barat (Surabaya)";
                  selectedStoreAddressId = surabayaCityId!;
                });
                fetchShippingOptions(); // Memuat opsi pengiriman setelah memilih alamat toko
              },
            ),
            getDivider(), // Memuat divider
            checkoutRow(
              "Alamat Rumah",
              trailingText: selectedHomeAddress != null
                  ? "${selectedHomeAddress!.cityName}, $detailedAddress"
                  : "Pilih",
              onTap: () {
                _showHomeAddressInputDialog(
                    context); // Menampilkan dialog untuk memilih alamat rumah
              },
            ),
            getDivider(), // Memuat divider
            checkoutRow(
              "Ekspedisi",
              trailingText: selectedCourier.isNotEmpty
                  ? selectedCourier.toUpperCase()
                  : "Pilih Ekspedisi",
              onTap: () {
                _showCourierSelectionDialog(
                    context); // Menampilkan dialog untuk memilih kurir pengiriman
              },
            ),
            getDivider(), // Memuat divider
            checkoutRow(
              "Metode Pembayaran",
              trailingText: selectedPaymentMethod.isNotEmpty
                  ? selectedPaymentMethod.toUpperCase()
                  : "Pilih Metode",
              onTap: () {
                _showPaymentMethodSelectionDialog(
                    context); // Menampilkan dialog untuk memilih metode pembayaran
              },
            ),
            if (selectedPaymentMethod.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Nomor Rekening',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        accountNumber = value;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                ],
              ),
            getDivider(), // Memuat divider
            rower(
              "Harga",
              trailingText:
                  "Rp${NumberFormat("#,##0", "id_ID").format(widget.totalPrice)}",
            ),
            getDivider(), // Memuat divider
            if (shippingOptions.isNotEmpty)
              rower(
                "Ongkir",
                trailingText:
                    "Rp${NumberFormat("#,##0", "id_ID").format(shippingCost)}",
              ),
            getDivider(), // Memuat divider
            rower(
              "Total",
              trailingText:
                  "Rp${NumberFormat("#,##0", "id_ID").format(totalCost)}",
            ),
            Container(
              margin: EdgeInsets.only(top: 25),
              child: AppButton(
                label: "Checkout",
                padding: EdgeInsets.symmetric(vertical: 25),
                color: Color.fromARGB(255, 0, 218, 94),
                textColor: Colors.white,
                onPressed: () {
                  placeOrder(); // Memanggil metode placeOrder untuk menempatkan pesanan
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

// Widget untuk dropdown search
  Widget dropdownSearch(
    String label, {
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 18,
                color: Color(0xFF7C7C7C),
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            value: items.isNotEmpty ? items[0] : null,
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

// Widget untuk mendapatkan divider
  Widget getDivider() {
    return Divider(
      thickness: 1,
      color: Color(0xFFE2E2E2),
    );
  }

// Widget untuk baris pada tampilan checkout
  Widget checkoutRow(String label,
      {String? trailingText, Widget? trailingWidget, VoidCallback? onTap}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF7C7C7C),
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            trailingText == null
                ? (trailingWidget ?? Container())
                : Text(
                    trailingText,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Gilroy',
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.arrow_forward_ios,
            ),
          ],
        ),
      ),
    );
  }

// Widget untuk baris spesifik dengan opsi tambahan di tampilan checkout
  Widget rower(String label,
      {String? trailingText, Widget? trailingWidget, VoidCallback? onTap}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF7C7C7C),
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            trailingText == null
                ? (trailingWidget ?? Container())
                : Text(
                    trailingText,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }

// Method untuk menampilkan dialog input alamat rumah
  void _showHomeAddressInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        Kota? newAddress;
        return AlertDialog(
          title: Text("Masukkan alamat rumah"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<Kota>(
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                value: cities.isNotEmpty ? cities[0] : null,
                items: cities.map((Kota item) {
                  return DropdownMenuItem<Kota>(
                    value: item,
                    child: Text(item.cityName ?? ""),
                  );
                }).toList(),
                onChanged: (Kota? newValue) {
                  newAddress = newValue;
                },
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Detail Alamat',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    detailedAddress = value;
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  selectedHomeAddress = newAddress;
                  fetchShippingOptions();
                });
                Navigator.of(context).pop();
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

// Method untuk menampilkan dialog pemilihan kurir pengiriman
  void _showCourierSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Select Courier"),
          content: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            value: selectedCourier.isNotEmpty ? selectedCourier : null,
            items: ["jne", "pos"].map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item.toUpperCase()),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedCourier = newValue ?? "";
                fetchShippingOptions();
              });
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  fetchShippingOptions();
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

// Method untuk menampilkan dialog pemilihan metode pembayaran
  void _showPaymentMethodSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Select Payment Method"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                value: selectedPaymentMethod.isNotEmpty
                    ? selectedPaymentMethod
                    : null,
                items: ["BCA", "BNI", "BRI", "Mandiri"].map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item.toUpperCase()),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedPaymentMethod = newValue ?? "";
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
// Melakukan aksi dengan selectedPaymentMethod dan accountNumber
                setState(() {
                  Navigator.of(context).pop();
                });
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => CheckoutBottomSheet(totalPrice: 100000),
            );
          },
          child: Text('Open Checkout'),
        ),
      ),
    );
  }
}
