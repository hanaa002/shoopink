import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_button.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/screens/login_screen.dart'; // Ubah ke login_screen.dart
import 'package:grocery_app/styles/colors.dart';

class WelcomeScreen extends StatelessWidget {
  final String imagePath = "assets/images/welcomesplashscreen.png";
  final String logoPath =
      "assets/images/logoshoopink.png"; // Updated path to the new logo image

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Spacer(),
              icon(),
              SizedBox(height: 20),
              welcomeTextWidget(),
              SizedBox(height: 10),
              sloganText(),
              SizedBox(height: 40),
              getButton(context),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget icon() {
    return Image.asset(
      logoPath, // Use the updated logo image path
      width: 100, // Adjust the width as needed
      height: 100, // Adjust the height as needed
    );
  }

  Widget welcomeTextWidget() {
    return Column(
      children: [
        AppText(
          text: "Welcome",
          fontSize: 48,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        AppText(
          text: "to our store",
          fontSize: 48,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ],
    );
  }

  Widget sloganText() {
    return AppText(
      text: "Get your groceries as fast as in an hour",
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Color(0xffFCFCFC).withOpacity(0.7),
    );
  }

  Widget getButton(BuildContext context) {
    return Container(
      width: double.infinity, // membuat tombol melebar sepanjang layar
      child: AppButton(
        label: "Get Started",
        fontWeight: FontWeight.w600,
        padding: EdgeInsets.symmetric(vertical: 25),
        onPressed: () {
          onGetStartedClicked(context);
        },
        color: Color.fromARGB(255, 0, 218, 94), // Set the button color to green
        textColor: Colors.white, // Set the text color to white
      ),
    );
  }

  void onGetStartedClicked(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (BuildContext context) {
        return LoginScreen(); // Redirect to LoginScreen
      },
    ));
  }
}
