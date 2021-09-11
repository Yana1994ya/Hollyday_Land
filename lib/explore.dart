import 'package:flutter/material.dart';

import './models/category.dart';
import './category_item.dart';

typedef void SelectCategory(Category category);

class Explore extends StatelessWidget {
  final Future<List<RootCategory>> rootCategories;
  final SelectCategory selectCategory;

  const Explore(
      {Key? key, required this.rootCategories, required this.selectCategory})
      : super(key: key);

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

          List<Widget> categoryWidget = categories
              .expand((r) => r.subCategories
                  .map((s) => CategoryItem(s, () => selectCategory(s)))
                  .toList())
              .toList();

          return GridView(
            padding: const EdgeInsets.all(15),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            children: categoryWidget,
          );
        }
      },
    );
  }
}
