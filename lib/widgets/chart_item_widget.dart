import 'package:flutter/material.dart';
import 'package:shoopink/common_widgets/app_text.dart';
import 'package:shoopink/models/grocery_item.dart';
import 'package:shoopink/styles/colors.dart';

import 'item_counter_widget.dart';

class ChartItemWidget extends StatefulWidget {
  ChartItemWidget({
    Key? key,
    required this.item,
    required this.onRemove,
    required this.amount,
    required this.onQuantityChanged,
  }) : super(key: key);
  
  final GroceryItem item;
  final VoidCallback onRemove;
  final int amount; // Add amount parameter here
  final void Function(GroceryItem item, int quantity) onQuantityChanged; // Update callback signature

  @override
  _ChartItemWidgetState createState() => _ChartItemWidgetState();
}

class _ChartItemWidgetState extends State<ChartItemWidget> {
  final double height = 110;
  final Color borderColor = Color(0xffE2E2E2);
  final double borderRadius = 18;
  int amount = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: EdgeInsets.symmetric(vertical: 30),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            imageWidget(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: widget.item.name,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 5),
                AppText(
                  text: widget.item.description,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkGrey,
                ),
                SizedBox(height: 12),
                Spacer(),
                ItemCounterWidget(
                  item: widget.item,
                  )
              ],
            ),
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.close, color: AppColors.darkGrey, size: 25),
                  onPressed: widget.onRemove,
                ),
                Spacer(flex: 5),
                Container(
                  width: 70,
                  child: AppText(
                    text: "Rp. ${getPrice().toStringAsFixed(0)}",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.right,
                  ),
                ),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget imageWidget() {
    return Container(
      width: 100,
      child: Image.asset(widget.item.imagePath),
    );
  }

  double getPrice() {
    return widget.item.price * amount;
  }
}
