class CategoryItem { // Deklarasi kelas CategoryItem untuk merepresentasikan item kategori.
  final int? id; // Properti id sebagai identifier item kategori (opsional).
  final String name; // Properti name untuk nama item kategori.
  final String imagePath; // Properti imagePath untuk path gambar item kategori.

  CategoryItem({this.id, required this.name, required this.imagePath}); // Konstruktor untuk inisialisasi properti.

}

var categoryItemsDemo = [ // Mendefinisikan variabel categoryItemsDemo sebagai daftar item kategori.
  CategoryItem( // Menginisialisasi objek CategoryItem pertama dalam daftar.
    name: "Buah & Sayuran Segar", // Memberikan nama kategori.
    imagePath: "assets/images/categories_images/fruit.png", // Memberikan path gambar kategori.
  ),
  CategoryItem( // Menginisialisasi objek CategoryItem kedua dalam daftar.
    name: "Minyak", // Memberikan nama kategori.
    imagePath: "assets/images/categories_images/oil.png", // Memberikan path gambar kategori.
  ),
  CategoryItem( // Menginisialisasi objek CategoryItem ketiga dalam daftar.
    name: "Daging & Ikan", // Memberikan nama kategori.
    imagePath: "assets/images/categories_images/meat.png", // Memberikan path gambar kategori.
  ),
  CategoryItem( // Menginisialisasi objek CategoryItem keempat dalam daftar.
    name: "Roti & Snacks", // Memberikan nama kategori.
    imagePath: "assets/images/categories_images/bakery.png", // Memberikan path gambar kategori.
  ),
  CategoryItem( // Menginisialisasi objek CategoryItem kelima dalam daftar.
    name: "Susu & Telur", // Memberikan nama kategori.
    imagePath: "assets/images/categories_images/dairy.png", // Memberikan path gambar kategori.
  ),
  CategoryItem( // Menginisialisasi objek CategoryItem keenam dalam daftar.
    name: "Minuman", // Memberikan nama kategori.
    imagePath: "assets/images/categories_images/beverages.png", // Memberikan path gambar kategori.
  ),
];
