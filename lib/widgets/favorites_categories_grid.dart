import "package:flutter/material.dart";
import "package:hollyday_land/models/favorites.dart";
import "package:hollyday_land/screens/museum/favorites.dart";
import 'package:hollyday_land/screens/winery/favorites.dart';
import "package:hollyday_land/widgets/category_item.dart";

class FavoritesCategoriesGrid extends StatelessWidget {
  final Favorites favorites;

  const FavoritesCategoriesGrid({Key? key, required this.favorites})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<CategoryItem> items = [
      if (favorites.museums > 0)
        CategoryItem(
          image: "assets/graphics/museums.jpg",
          title: "Museums",
          path: FavoritesMuseumsScreen.routePath,
        ),
      if (favorites.wineries > 0)
        CategoryItem(
          image: "assets/graphics/wineries.jpg",
          title: "Wineries",
          path: FavoritesWineriesScreen.routePath,
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
