import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shoopink/common_widgets/app_text.dart';
import 'package:shoopink/models/grocery_item.dart';
import 'package:shoopink/screens/product_details/product_details_screen.dart';
import 'package:shoopink/widgets/grocery_item_card_widget.dart';

import 'filter_screen.dart';

class CategoryItemsScreen extends StatefulWidget {
  @override
  _CategoryItemsScreenState createState() => _CategoryItemsScreenState();
}

class _CategoryItemsScreenState extends State<CategoryItemsScreen> {
  List<GroceryItem> _filteredItems = beverages;

  void _searchItems(String query) {
    final filteredItems = beverages.where((item) {
      final itemNameLower = item.name.toLowerCase();
      final searchLower = query.toLowerCase();

      return itemNameLower.contains(searchLower);
    }).toList();

    setState(() {
      _filteredItems = filteredItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Ensure the Scaffold background is white
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.only(left: 25),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FilterScreen()),
              );
            },
            child: Container(
              padding: EdgeInsets.only(right: 25),
              child: Icon(
                Icons.sort,
                color: Colors.black,
              ),
            ),
          ),
        ],
        title: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: AppText(
            text: "Beverages",
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _searchItems,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: StaggeredGrid.count(
                crossAxisCount: 2,
                children: _filteredItems.asMap().entries.map<Widget>((e) {
                  GroceryItem groceryItem = e.value;
                  return GestureDetector(
                    onTap: () {
                      onItemClicked(context, groceryItem);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: GroceryItemCardWidget(
                        item: groceryItem,
                        heroSuffix: "explore_screen",
                      ),
                    ),
                  );
                }).toList(),
                mainAxisSpacing: 3.0,
                crossAxisSpacing: 0.0, // add some space
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onItemClicked(BuildContext context, GroceryItem groceryItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(
          groceryItem,
          heroSuffix: "explore_screen",
        ),
      ),
    );
  }
}
