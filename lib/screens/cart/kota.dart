class Kota {
  String? cityId; // ID kota
  String? type; // Jenis kota (misalnya Kota, Kabupaten)
  String? cityName; // Nama kota

  Kota({this.cityId, this.type, this.cityName}); // Constructor Kota

  Kota.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id']; // Mengambil nilai city_id dari JSON
    type = json['type']; // Mengambil nilai type dari JSON
    cityName = json['city_name']; // Mengambil nilai city_name dari JSON
  }

  @override
  String toString() => cityName as String; // Override metode toString untuk mengembalikan nama kota sebagai String

  static List<Kota> fromJsonList(List list) {
    if (list.length == 0) return List<Kota>.empty(); // Mengembalikan list kosong jika list input kosong
    return list.map((item) => Kota.fromJson(item)).toList(); // Mengonversi setiap item dalam list menjadi objek Kota dan mengembalikan sebagai List<Kota>
  }
}
