import 'package:flutter/material.dart';

class OrderAcceptedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(
              flex: 10,
            ),
            Icon(
              Icons.check_circle,
              size: 100,
              color: Colors.green,
            ),
            Spacer(
              flex: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Your Order Has Been Accepted",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Your item has been placed and is on its way to being processed",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff7C7C7C),
                    fontWeight: FontWeight.w600),
              ),
            ),
            Spacer(
              flex: 8,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(
                        255, 0, 218, 94)), // Set button color to pink
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  "Track Order",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white, // Set text color to white
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Spacer(
              flex: 2,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                "Back To Home",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Spacer(
              flex: 10,
            ),
          ],
        ),
      ),
    );
  }
}
