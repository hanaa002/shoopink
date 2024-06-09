// cart_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shoopink/providers/cart_provider.dart';
import 'package:shoopink/common_widgets/app_button.dart';
import 'package:shoopink/helpers/column_with_seprator.dart';
import 'package:shoopink/widgets/chart_item_widget.dart';
import 'checkout_bottom_sheet.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
   double totalPrice  = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 25),
              Text(
                "My Cart",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Consumer<CartProvider>(
                builder: (context, cartProvider, child) {
                  return Column(
                    children: getChildrenWithSeperator(
                      addToLastChild: false,
                      widgets: cartProvider.cartItems.map((e) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          width: double.maxFinite,
                          child:ChartItemWidget(
                            item: e,
                            onRemove: () {
                              cartProvider.removeItem(e);
                            },
                            onQuantityChanged: (item, quantity) {
                              // Handle quantity change
                              setState(() {
                                // Update the quantity of the item in the cart
                                cartProvider.updateItemQuantity(item, quantity);
                              });
                            }, amount: 0,
                          ),
                        );
                      }).toList(),
                      seperator: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Divider(thickness: 1),
                      ),
                    ),
                  );
                },
              ),
              Divider(thickness: 1),
              getCheckoutButton(context)
            ],
          ),
        ),
      ),
    );
  }

Widget getCheckoutButton(BuildContext context) {
  return Consumer<CartProvider>(
    builder: (context, cartProvider, child) {
      // Recalculate the total price whenever the quantity changes
       totalPrice = cartProvider.cartItems.fold(0, (sum, item) => sum + (item.price * item.amount));

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: AppButton(
          label: "Go To Check Out",
          fontWeight: FontWeight.w600,
          padding: EdgeInsets.symmetric(vertical: 30),
          color: Color.fromARGB(255, 0, 218, 94),
          textColor: Color.fromARGB(255, 0, 218, 94),
          trailingWidget: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 0, 218, 94),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              "Rp${NumberFormat("#,##0", "id_ID").format(totalPrice)}",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          onPressed: () {
            showBottomSheet(context);
          },
        ),
      );
    },
  );
}

  void showBottomSheet(context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext bc) {
      return CheckoutBottomSheet(totalPrice: totalPrice); // Pass totalPrice to CheckoutBottomSheet
    },
  );
}

}
