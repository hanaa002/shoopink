// Import paket Flutter yang diperlukan
import 'package:flutter/material.dart';

// Deklarasi fungsi getChildrenWithSeperator untuk menghasilkan list widget dengan separator di antara mereka
List<Widget> getChildrenWithSeperator(
    {required List<Widget> widgets, // Parameter wajib: list widget yang akan dipisahkan
    required Widget seperator, // Parameter wajib: widget sebagai separator
    bool addToLastChild = true}) { // Parameter opsional: menentukan apakah menambahkan separator ke child terakhir atau tidak
  List<Widget> children = []; // Inisialisasi list kosong untuk menampung children

  if (widgets.length > 0) { // Memeriksa apakah list widgets memiliki elemen
    children.add(seperator); // Menambahkan separator sebelum menambahkan widget pertama

    for (int i = 0; i < widgets.length; i++) { // Iterasi melalui setiap widget dalam list widgets
      children.add(widgets[i]); // Menambahkan widget ke list children

      if (widgets.length - i == 1) { // Memeriksa jika ini adalah child terakhir
        if (addToLastChild) { // Jika addToLastChild true, tambahkan separator setelah child terakhir
          children.add(seperator);
        }
      } else { // Jika bukan child terakhir, tambahkan separator setelah setiap child
        children.add(seperator);
      }
    }
  }
  return children; // Mengembalikan list children yang sudah dimodifikasi dengan separator
}
