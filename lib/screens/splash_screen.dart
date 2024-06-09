import 'dart:async';
import 'package:flutter/material.dart';
import 'package:grocery_app/screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    const delay = Duration(seconds: 3);
    Future.delayed(delay, () => onTimerFinished());
  }

  void onTimerFinished() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (BuildContext context) {
        return WelcomeScreen();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 218, 94),
      body: Center(
        child: splashScreenContent(),
      ),
    );
  }
}

Widget splashScreenContent() {
  final String logoPath = "assets/images/logoshoopink.png";

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Image.asset(
        logoPath,
        width: 100,
        height: 100,
      ),
      SizedBox(height: 20),
      Text(
        "SHOPINK",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ],
  );
}
