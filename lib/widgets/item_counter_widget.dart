import 'package:flutter/material.dart';
import 'package:shoopink/models/grocery_item.dart';
import 'package:shoopink/styles/colors.dart';

class ItemCounterWidget extends StatefulWidget {
  final GroceryItem item;
  final Function(GroceryItem item, int newAmount)? onAmountChanged;

  const ItemCounterWidget({
    Key? key,
    required this.item,
    this.onAmountChanged,
  }) : super(key: key);

  @override
  _ItemCounterWidgetState createState() => _ItemCounterWidgetState();
}

class _ItemCounterWidgetState extends State<ItemCounterWidget> {
  int amount = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        iconWidget(Icons.remove, iconColor: AppColors.darkGrey, onPressed: decrementAmount),
        SizedBox(width: 18),
        Container(
          width: 30,
          child: Center(child: getText(text: amount.toString(), fontSize: 18, isBold: true, fontFamily: 'Gilroy')),
        ),
        SizedBox(width: 18),
        iconWidget(Icons.add, iconColor: AppColors.primaryColor, onPressed: incrementAmount)
      ],
    );
  }

  void incrementAmount() {
    setState(() {
      amount = amount + 1;
      updateParent();
    });
  }

  void decrementAmount() {
    if (amount <= 1) return; // Updated condition to prevent negative amount
    setState(() {
      amount = amount - 1;
      updateParent();
    });
  }

  void updateParent() {
    if (widget.onAmountChanged != null) {
      widget.onAmountChanged!(widget.item, amount); // Pass the item and the new amount
    }
  }

  Widget iconWidget(IconData iconData, {Color? iconColor, onPressed}) {
    return GestureDetector(
      onTap: () {
        if (onPressed != null) {
          onPressed();
        }
      },
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: Color(0xffE2E2E2),
          ),
        ),
        child: Center(
          child: Icon(
            iconData,
            color: iconColor ?? Colors.black,
            size: 25,
          ),
        ),
      ),
    );
  }

  Widget getText({
    required String text,
    required double fontSize,
    bool isBold = false,
    Color color = Colors.black,
    String fontFamily = 'Gilroy',
  }) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        color: color,
        fontFamily: fontFamily,
      ),
    );
  }
}
