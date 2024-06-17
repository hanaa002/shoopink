//creator_profile.dart

class CreatorProfile { // Deklarasi kelas CreatorProfile untuk menyimpan data profil pengembang.
  final String fullName; // Variabel untuk nama lengkap pengembang.
  final String university; // Variabel untuk universitas pengembang.
  final String faculty; // Variabel untuk fakultas pengembang.
  final String major; // Variabel untuk jurusan pengembang.
  final String npm; // Variabel untuk NPM (Nomor Pokok Mahasiswa) pengembang.
  final String email; // Variabel untuk email pengembang.
  final String github; // Variabel untuk username GitHub pengembang.
  final String image; // Variabel untuk path gambar profil pengembang.

  CreatorProfile({ // Konstruktor untuk inisialisasi data pada kelas CreatorProfile.
    required this.fullName, // Inisialisasi nama lengkap, wajib diisi.
    required this.university, // Inisialisasi universitas, wajib diisi.
    required this.faculty, // Inisialisasi fakultas, wajib diisi.
    required this.major, // Inisialisasi jurusan, wajib diisi.
    required this.npm, // Inisialisasi NPM, wajib diisi.
    required this.email, // Inisialisasi email, wajib diisi.
    required this.github, // Inisialisasi GitHub, wajib diisi.
    required this.image, // Inisialisasi path gambar profil, wajib diisi.
  });
}
