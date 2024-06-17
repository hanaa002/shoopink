// File ini dihasilkan oleh FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions; // Import FirebaseOptions dari package firebase_core
import 'package:flutter/foundation.dart' // Import beberapa konstanta dari package flutter
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] untuk digunakan dengan aplikasi Firebase Anda.
///
/// Contoh:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  // Fungsi statis untuk mendapatkan FirebaseOptions berdasarkan platform yang digunakan
  static FirebaseOptions get currentPlatform {
    // Jika berjalan di web, kembalikan konfigurasi web
    if (kIsWeb) {
      return web;
    }
    // Switch case untuk menentukan platform selain web
    switch (defaultTargetPlatform) {
      // Jika platform adalah Android, kembalikan konfigurasi android
      case TargetPlatform.android:
        return android;
      // Jika platform adalah iOS, kembalikan konfigurasi ios
      case TargetPlatform.iOS:
        return ios;
      // Jika platform adalah macOS, lempar error karena tidak dikonfigurasi
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions belum dikonfigurasi untuk macos - '
          'Anda dapat mengonfigurasinya kembali dengan menjalankan FlutterFire CLI lagi.',
        );
      // Jika platform adalah Windows, lempar error karena tidak dikonfigurasi
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions belum dikonfigurasi untuk windows - '
          'Anda dapat mengonfigurasinya kembali dengan menjalankan FlutterFire CLI lagi.',
        );
      // Jika platform adalah Linux, lempar error karena tidak dikonfigurasi
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions belum dikonfigurasi untuk linux - '
          'Anda dapat mengonfigurasinya kembali dengan menjalankan FlutterFire CLI lagi.',
        );
      // Default case, lempar error karena platform tidak didukung
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions tidak didukung untuk platform ini.',
        );
    }
  }

  // Konfigurasi FirebaseOptions untuk web
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCLSbrOp2O5PdjRbF9x5LccNVViDkIp9Yo', // API key untuk aplikasi web
    appId: '1:63028058946:web:523fb24a1f2ddf898b86db', // App ID untuk aplikasi web
    messagingSenderId: '63028058946', // Sender ID untuk messaging
    projectId: 'shoopink-c9cb0', // Project ID Firebase
    authDomain: 'shoopink-c9cb0.firebaseapp.com', // Domain autentikasi untuk web
    storageBucket: 'shoopink-c9cb0.appspot.com', // Storage bucket untuk web
    measurementId: 'G-GSM736WND4', // Measurement ID untuk analitik
  );

  // Konfigurasi FirebaseOptions untuk Android
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyADRATS9ZLAq-EZN-cJIopexQmrPiFBrc4', // API key untuk aplikasi Android
    appId: '1:63028058946:android:c311dd8aa2004f2d8b86db', // App ID untuk aplikasi Android
    messagingSenderId: '63028058946', // Sender ID untuk messaging
    projectId: 'shoopink-c9cb0', // Project ID Firebase
    storageBucket: 'shoopink-c9cb0.appspot.com', // Storage bucket untuk Android
  );

  // Konfigurasi FirebaseOptions untuk iOS
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC46jugA3LIH-y9i9cK0wJJpXDsDFVOvFY', // API key untuk aplikasi iOS
    appId: '1:63028058946:ios:e035de737806fafd8b86db', // App ID untuk aplikasi iOS
    messagingSenderId: '63028058946', // Sender ID untuk messaging
    projectId: 'shoopink-c9cb0', // Project ID Firebase
    storageBucket: 'shoopink-c9cb0.appspot.com', // Storage bucket untuk iOS
    iosBundleId: 'com.example.groceryApp', // Bundle ID untuk aplikasi iOS
  );
}
