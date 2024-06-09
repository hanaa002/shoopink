import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final ValueChanged<String> onSearch;

  SearchBarWidget({required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        onChanged: onSearch,
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
    );
  }
}
