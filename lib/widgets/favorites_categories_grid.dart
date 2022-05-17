import "package:flutter/material.dart";
import "package:hollyday_land/models/attractions_count.dart";
import "package:hollyday_land/screens/extreme_sports/favorites.dart";
import "package:hollyday_land/screens/hot_air/favorites.dart";
import "package:hollyday_land/screens/museum/favorites.dart";
import "package:hollyday_land/screens/offroad/favorites.dart";
import "package:hollyday_land/screens/rock_climbing/favorites.dart";
import 'package:hollyday_land/screens/tour/favorites.dart';
import "package:hollyday_land/screens/trail/favorites.dart";
import "package:hollyday_land/screens/water_sports/favorites.dart";
import "package:hollyday_land/screens/winery/favorites.dart";
import "package:hollyday_land/screens/zoo/favorites.dart";
import "package:hollyday_land/widgets/categories_grid.dart";
import "package:hollyday_land/widgets/category_item.dart";

class FavoritesCategoriesGrid extends StatelessWidget {
  final AttractionsCount favorites;

  const FavoritesCategoriesGrid({Key? key, required this.favorites})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<CategoryItem> items = CategoriesGrid.optionalCategoryItems(
      attractionsCount: favorites,
      museumsPath: FavoritesMuseumsScreen.routePath,
      wineriesPath: FavoritesWineriesScreen.routePath,
      zoosPath: FavoritesZoosScreen.routePath,
      offRoadTripsPath: FavoritesOffRoadTripsScreen.routePath,
      trailsPath: FavoritesTrailsScreen.routePath,
      waterSportsPath: FavoritesWaterSportsScreen.routePath,
      rockClimbingPath: FavoritesRockClimbingScreen.routePath,
      extremeSportsPath: FavoritesExtremeSportsScreen.routePath,
      hotAirPath: FavoritesHotAirScreen.routePath,
      toursPath: FavoritesToursScreen.routePath,
    );

    return GridView.builder(
      padding: const EdgeInsets.all(15),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: CategoriesGrid.mainAxisSpacing,
      ),
      itemBuilder: (_, index) => items[index],
      itemCount: items.length,
    );
  }
}
