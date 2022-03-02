import "package:flutter/material.dart";
import "package:hollyday_land/models/attractions_count.dart";
import "package:hollyday_land/screens/museum/history.dart";
import "package:hollyday_land/screens/offroad/history.dart";
import "package:hollyday_land/screens/rock_climbing/history.dart";
import "package:hollyday_land/screens/trail/history.dart";
import "package:hollyday_land/screens/water_sports/history.dart";
import "package:hollyday_land/screens/winery/history.dart";
import "package:hollyday_land/screens/zoo/history.dart";
import "package:hollyday_land/widgets/categories_grid.dart";
import "package:hollyday_land/widgets/category_item.dart";

class HistoryCategoriesGrid extends StatelessWidget {
  final AttractionsCount history;

  const HistoryCategoriesGrid({Key? key, required this.history})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<CategoryItem> items = CategoriesGrid.optionalCategoryItems(
      attractionsCount: history,
      museumsPath: HistoryMuseumsScreen.routePath,
      wineriesPath: HistoryWineriesScreen.routePath,
      zoosPath: HistoryZoosScreen.routePath,
      offRoadTripsPath: HistoryOffRoadTripsScreen.routePath,
      trailsPath: HistoryTrailsScreen.routePath,
      waterSportsPath: HistoryWaterSportsScreen.routePath,
      rockClimbingPath: HistoryRockClimbingScreen.routePath,
    );

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
