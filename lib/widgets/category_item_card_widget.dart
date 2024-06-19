import 'package:flutter/material.dart'; // Mengimpor package flutter/material.dart untuk menggunakan Flutter UI framework.
import 'package:shoopink/common_widgets/app_text.dart'; // Mengimpor widget AppText dari direktori common_widgets/app_text.dart.
import 'package:shoopink/models/category_item.dart'; // Mengimpor model CategoryItem dari direktori models/category_item.dart.

class CategoryItemCardWidget extends StatelessWidget { // Deklarasi class CategoryItemCardWidget sebagai StatelessWidget.
  CategoryItemCardWidget({
    Key? key,
    required this.item,
    this.color = Colors.blue, // Mengatur warna default menjadi Colors.blue jika tidak di-set.
  }) : super(key: key);

  final CategoryItem item; // Deklarasi variabel item bertipe CategoryItem sebagai data untuk widget ini.
  final double height = 200.0; // Tinggi widget ini.
  final double width = 175.0; // Lebar widget ini.
  final Color borderColor = Color(0xffE2E2E2); // Warna border.
  final double borderRadius = 18; // BorderRadius untuk border.
  final Color color; // Warna latar belakang widget ini.

  @override
  Widget build(BuildContext context) { // Method build untuk membangun tampilan widget.
    return Container( // Menggunakan Container sebagai parent widget.
      padding: EdgeInsets.only(top: 5, bottom: 5), // Padding atas dan bawah Container.
      decoration: BoxDecoration( // Mendefinisikan dekorasi Container.
        color: color.withOpacity(0.1), // Memberikan warna latar belakang dengan opacity.
        borderRadius: BorderRadius.circular(18), // BorderRadius untuk sudut container.
        border: Border.all( // Menambahkan border.
          color: color.withOpacity(0.7), // Warna border dengan opacity.
          width: 2, // Lebar border.
        ),
      ),
      child: Column( // Menggunakan Column untuk susunan widget secara vertikal.
        crossAxisAlignment: CrossAxisAlignment.center, // Menyusun widget secara memanjang di tengah.
        children: [
          Container( // Container untuk menampilkan gambar.
            height: 120, // Tinggi Container gambar.
            width: 120, // Lebar Container gambar.
            child: imageWidget(), // Menampilkan gambar menggunakan method imageWidget().
          ),
          SizedBox( // SizedBox untuk memberikan jarak vertical.
            height: 60, // Tinggi SizedBox.
            child: Center( // Center untuk menyusun teks di tengah.
              child: AppText( // Widget AppText untuk menampilkan teks.
                text: item.name, // Mengambil nama item dari CategoryItem.
                textAlign: TextAlign.center, // Posisi teks menjadi tengah.
                fontSize: 16, // Ukuran teks.
                fontWeight: FontWeight.bold, // Ketebalan teks.
                fontFamily: 'Gilroy', // Menggunakan font family Gilroy.
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget imageWidget() { // Method imageWidget untuk menampilkan gambar.
    return Container( // Container untuk menampilkan gambar.
      child: Image.asset( // Widget Image.asset untuk menampilkan gambar dari asset.
        item.imagePath, // Path gambar diambil dari CategoryItem.
        fit: BoxFit.contain, // Menyesuaikan gambar ke dalam Container.
      ),
    );
  }
}
