// Import paket cloud_firestore untuk mengakses Firestore
import 'package:cloud_firestore/cloud_firestore.dart';

// Definisikan kelas OrdersDB untuk mengelola koleksi orders di Firestore
class OrdersDB {
  // Deklarasikan referensi ke koleksi orders di Firestore
  final CollectionReference _ordersCollection =
      FirebaseFirestore.instance.collection('Orders');

  // Fungsi untuk mendapatkan daftar semua orders
  Future<List<Map<String, dynamic>>> getOrdersList() async {
    try {
      // Ambil snapshot dari koleksi orders
      QuerySnapshot querySnapshot = await _ordersCollection.get();
      // Ubah setiap dokumen menjadi map dan sertakan ID dokumen
      return querySnapshot.docs.map((doc) {
        // Konversi data dokumen ke Map<String, dynamic>
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        // Sertakan ID dokumen dalam data
        data['RXg046b1hNFcIrHpEBQi'] = doc.id;  // Include the Document ID
        return data;
      }).toList(); // Kembalikan daftar map
    } catch (e) {
      // Cetak pesan error jika terjadi kesalahan
      print("Error fetching orders: $e");
      // Kembalikan daftar kosong jika terjadi kesalahan
      return [];
    }
  }

  // Fungsi untuk mendapatkan daftar orders berdasarkan user ID
  Future<List<Map<String, dynamic>>> getOrdersListForUser(String userId) async {
    try {
      // Ambil snapshot dari koleksi orders dengan kondisi userId yang sesuai
      QuerySnapshot querySnapshot = await _ordersCollection
          .where('userId', isEqualTo: userId) // Filter berdasarkan userId
          .get();
      // Ubah setiap dokumen menjadi map dan sertakan ID dokumen
      return querySnapshot.docs.map((doc) {
        // Konversi data dokumen ke Map<String, dynamic>
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        // Sertakan ID dokumen dalam data
        data['RXg046b1hNFcIrHpEBQi'] = doc.id;  // Include the Document ID
        return data;
      }).toList(); // Kembalikan daftar map
    } catch (e) {
      // Cetak pesan error jika terjadi kesalahan
      print("Error fetching orders for user $userId: $e");
      // Kembalikan daftar kosong jika terjadi kesalahan
      return [];
    }
  }

  // Fungsi untuk menambahkan order baru ke koleksi
  Future<void> addOrder(Map<String, dynamic> orderData) async {
    try {
      // Tambahkan data order ke koleksi orders
      await _ordersCollection.add(orderData);
    } catch (e) {
      // Cetak pesan error jika terjadi kesalahan
      print("Error adding order: $e");
      // Optional: lempar kembali error untuk ditangani di tempat lain
      throw e; // Optional: re-throw the error to handle it elsewhere
    }
  }
}
