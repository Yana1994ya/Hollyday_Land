import 'package:flutter/material.dart';
import 'package:hollyday_land/widgets/categories_grid.dart';

class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Explore"),),
      body: CategoriesGrid(),
    );
  }
}
