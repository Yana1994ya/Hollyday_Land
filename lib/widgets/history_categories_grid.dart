import "package:flutter/material.dart";
import "package:hollyday_land/models/history.dart";
import "package:hollyday_land/screens/museum/history.dart";
import "package:hollyday_land/screens/winery/history.dart";
import "package:hollyday_land/screens/zoo/history.dart";
import "package:hollyday_land/widgets/category_item.dart";

class HistoryCategoriesGrid extends StatelessWidget {
  final History history;

  const HistoryCategoriesGrid({Key? key, required this.history})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<CategoryItem> items = [
      if (history.museums > 0)
        CategoryItem(
          image: "assets/graphics/museums.jpg",
          title: "Museums",
          path: HistoryMuseumsScreen.routePath,
        ),
      if (history.wineries > 0)
        CategoryItem(
          image: "assets/graphics/wineries.jpg",
          title: "Wineries",
          path: HistoryWineriesScreen.routePath,
        ),
      if (history.zoos > 0)
        CategoryItem(
          image: "assets/graphics/zoos.jpg",
          title: "Zoos",
          path: HistoryZoosScreen.routePath,
        ),
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
