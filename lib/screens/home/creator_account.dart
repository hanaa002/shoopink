import 'package:flutter/material.dart';
import 'package:grocery_app/common_widgets/app_text.dart';
import 'package:grocery_app/styles/colors.dart';

class CreatorAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Creator Account'),
      ),
      body: ListView(
        children: [
          CreatorCard(
            name: 'John Doe',
            description: 'Photographer | @johndoe',
            image: 'assets/images/john_doe.jpg',
          ),
          CreatorCard(
            name: 'Jane Smith',
            description: 'Painter | @janesmith',
            image: 'assets/images/jane_smith.jpg',
          ),
        ],
      ),
    );
  }
}

class CreatorCard extends StatelessWidget {
  final String name;
  final String description;
  final String image;

  CreatorCard({
    required this.name,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(image),
        ),
        title: Text(name),
        subtitle: Text(description),
        onTap: () {
          // Action when tapped on creator card
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CreatorAccountPage(),
  ));
}
