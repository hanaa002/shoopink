import 'package:flutter/material.dart';
import 'package:shoopink/screens/splash_screen.dart';
import 'package:shoopink/styles/theme.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      home: SplashScreen(),
    );
  }
}
