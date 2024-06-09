import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shoopink/common_widgets/app_text.dart';
import 'package:shoopink/models/category_item.dart';
import 'package:shoopink/widgets/category_item_card_widget.dart';

import 'category_items_screen.dart';

List<Color> gridColors = [
  Color(0xff53B175),
  Color(0xffF8A44C),
  Color(0xffF7A593),
  Color(0xffD3B0E0),
  Color(0xffFDE598),
  Color(0xffB7DFF5),
  Color(0xff836AF6),
  Color(0xffD73B77),
];

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<CategoryItem> _filteredCategoryItems = categoryItemsDemo;

  void _searchCategoryItems(String query) {
    final filteredItems = categoryItemsDemo.where((item) {
      final itemNameLower = item.name.toLowerCase();
      final searchLower = query.toLowerCase();

      return itemNameLower.contains(searchLower);
    }).toList();

    setState(() {
      _filteredCategoryItems = filteredItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.white, // Pastikan background Scaffold adalah putih
      body: SafeArea(
        child: Column(
          children: [
            getHeader(),
            Expanded(
              child: getStaggeredGridView(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget getHeader() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Center(
          child: AppText(
            text: "Cari Produk",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget getStaggeredGridView(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        children: _filteredCategoryItems.asMap().entries.map<Widget>((e) {
          int index = e.key;
          CategoryItem categoryItem = e.value;
          return GestureDetector(
            onTap: () {
              onCategoryItemClicked(context, categoryItem);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: CategoryItemCardWidget(
                item: categoryItem,
                color: gridColors[index % gridColors.length],
              ),
            ),
          );
        }).toList(),
        mainAxisSpacing: 3.0,
        crossAxisSpacing: 4.0, // tambahkan sedikit ruang
      ),
    );
  }

  void onCategoryItemClicked(BuildContext context, CategoryItem categoryItem) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) {
        return CategoryItemsScreen();
      },
    ));
  }
}
