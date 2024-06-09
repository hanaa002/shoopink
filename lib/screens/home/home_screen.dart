import 'package:flutter/material.dart';
import 'package:grocery_app/models/grocery_item.dart';
import 'package:grocery_app/screens/product_details/product_details_screen.dart';
import 'package:grocery_app/styles/colors.dart';
import 'package:grocery_app/widgets/grocery_item_card_widget.dart';
import 'package:grocery_app/widgets/search_bar_widget.dart'
    as search_bar_widget;
import 'grocery_featured_Item_widget.dart';
import 'home_banner_widget.dart';
import 'package:intl/intl.dart';
import 'creator_account.dart'; // Impor halaman Creator Account

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigasi ke halaman Creator Account saat tombol ditekan
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreatorAccountPage()),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(Icons.menu), // Ubah ikon sesuai kebutuhan
                        ),
                      ),
                      SizedBox(width: 10),
                      Padding(
                        padding: EdgeInsets.only(
                            left:
                                170), // Mengatur jarak dari sisi kanan sejauh 10 piksel
                        child: Image.asset(
                          'assets/images/logoshoopink.png',
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: locationWidget(),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: search_bar_widget.SearchBarWidget(),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: HomeBanner(),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: subTitle("Exclusive Order"),
                ),
                getHorizontalItemSlider(exclusiveOffers),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: subTitle("Best Selling"),
                ),
                getHorizontalItemSlider(bestSelling),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: subTitle("Groceries"),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    height: 105,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(width: 20),
                        GroceryFeaturedCard(
                          groceryFeaturedItems[0],
                          color: Color(0xffF8A44C),
                        ),
                        SizedBox(width: 20),
                        GroceryFeaturedCard(
                          groceryFeaturedItems[1],
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: getHorizontalItemSlider(groceries),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getHorizontalItemSlider(List<GroceryItem> items) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 250,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onItemClicked(context, items[index]);
            },
            child: GroceryItemCardWidget(
              item: items[index],
              heroSuffix: "home_screen",
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 20);
        },
      ),
    );
  }

  void onItemClicked(BuildContext context, GroceryItem groceryItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(
          groceryItem,
          heroSuffix: "home_screen",
        ),
      ),
    );
  }

  Widget subTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Text(
            "",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }

  Widget locationWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.location_on,
          color: Color.fromARGB(255, 218, 0, 0),
        ),
        SizedBox(width: 8),
        Text(
          "Toko Swalayan Aini",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

String formatPrice(double price) {
  final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
  return formatter.format(price);
}
