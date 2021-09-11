import 'package:flutter/material.dart';

import './models/category.dart';
import './category_item.dart';

class Explore extends StatelessWidget {
  final Future<List<RootCategory>> rootCategories;

  const Explore({Key? key, required this.rootCategories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: rootCategories,
      builder: (ctx, snapshot) {
        if (snapshot.hasError) {
          return Text("error encountered when retriving data");
        } else if (!snapshot.hasData) {
          return CircularProgressIndicator();
        } else {
          final List<RootCategory> categories =
              snapshot.data as List<RootCategory>;

          return ListView(
            children: categories.map((r) => rootCategory(r)).toList(),
          );
        }
      },
    );
  }

  Widget rootCategory(RootCategory rootCategory) {
    // Calculation of the GridView size
    final int rows = (rootCategory.subCategories.length / 2).ceil();
    double height = rows * 122 + (rows - 1) * 20 + 30;

    return Column(
      children: [
        Text(rootCategory.category.title),
        Container(
          height: height,
          //decoration: BoxDecoration(color: Colors.green),
          child: GridView(
            padding: const EdgeInsets.all(15),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            children: rootCategory.subCategories
                .map((category) => CategoryItem(category))
                .toList(),
          ),
        )
      ],
    );
  }
}
