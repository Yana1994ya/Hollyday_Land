import "package:flutter/material.dart";
import "package:hollyday_land/screens/museum/museums.dart";
import "package:hollyday_land/screens/winery/wineries.dart";
import "package:hollyday_land/screens/zoo/zoos.dart";
import "package:hollyday_land/widgets/category_item.dart";

class CategoriesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<CategoryItem> items = [
      CategoryItem(
        image: "assets/graphics/museums.jpg",
        title: "Museums",
        path: MuseumsScreen.routePath,
      ),
      CategoryItem(
        image: "assets/graphics/wineries.jpg",
        title: "Wineries",
        path: WineriesScreen.routePath,
      ),
      CategoryItem(
        image: "assets/graphics/zoos.jpg",
        title: "Zoos",
        path: ZoosScreen.routePath,
      )
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(15),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (_, index) => items[index],
      itemCount: items.length,
    );
  }
}
