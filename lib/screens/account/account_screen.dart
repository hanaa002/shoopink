import 'package:flutter/material.dart';
import 'package:shoopink/common_widgets/app_text.dart';
import 'package:shoopink/styles/colors.dart';

import 'account_item.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white, // Mengatur latar belakang menjadi putih
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading:
                    SizedBox(width: 65, height: 65, child: getImageHeader()),
                title: AppText(
                  text: "Ryu Sunjae",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                subtitle: AppText(
                  text: "",
                  color: Color(0xff7C7C7C),
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
              Column(
                children: getChildrenWithSeparator(
                  widgets: accountItems.map((e) {
                    return getAccountItemWidget(e);
                  }).toList(),
                  separator: Divider(
                    thickness: 1,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              logoutButton(),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget lainnya tidak diubah karena hanya mempengaruhi tampilan konten

  Widget logoutButton() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          visualDensity: VisualDensity.compact,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          elevation: 0,
          backgroundColor: Color(0xffF2F3F2),
          textStyle: TextStyle(
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 25),
          minimumSize: const Size.fromHeight(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.logout,
              color: Colors.black,
              size: 20,
            ),
            Text(
              "Log Out",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor),
            ),
            Container()
          ],
        ),
        onPressed: () {},
      ),
    );
  }

  Widget getImageHeader() {
    String imagePath = "assets/images/account_image.jpg";
    return CircleAvatar(
      radius: 5.0,
      backgroundImage: AssetImage(imagePath),
      backgroundColor: AppColors.primaryColor.withOpacity(0.7),
    );
  }

  Widget getAccountItemWidget(AccountItem accountItem) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Icon(
            accountItem.icon,
            color: Colors.black,
            size: 20,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            accountItem.label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }

  List<Widget> getChildrenWithSeparator({
    required List<Widget> widgets,
    required Widget separator,
  }) {
    if (widgets.isEmpty) {
      return [];
    }

    final List<Widget> separatedWidgets = [];
    for (int i = 0; i < widgets.length; i++) {
      separatedWidgets.add(widgets[i]);
      if (i != widgets.length - 1) {
        separatedWidgets.add(separator);
      }
    }
    return separatedWidgets;
  }
}
