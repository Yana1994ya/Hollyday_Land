import "package:flutter/material.dart";
import "package:hollyday_land/models/attractions_count.dart";
import "package:hollyday_land/screens/extreme_sports/list.dart";
import "package:hollyday_land/screens/hot_air/hot_air_list.dart";
import "package:hollyday_land/screens/museum/museums.dart";
import "package:hollyday_land/screens/offroad/trips.dart";
import "package:hollyday_land/screens/rock_climbing/list.dart";
import "package:hollyday_land/screens/trail/trails.dart";
import "package:hollyday_land/screens/water_sports/list.dart";
import "package:hollyday_land/screens/winery/wineries.dart";
import "package:hollyday_land/screens/zoo/zoos.dart";
import "package:hollyday_land/widgets/category_item.dart";

class CategoriesGrid extends StatelessWidget {
  static const double mainAxisSpacing = 15;

  static CategoryItem _museumsItem(String path) {
    return CategoryItem(
      image: "assets/graphics/museums.jpg",
      title: "Museums",
      path: path,
    );
  }

  static CategoryItem _wineriesItem(String path) {
    return CategoryItem(
      image: "assets/graphics/wineries.jpg",
      title: "Wineries",
      path: path,
    );
  }

  static CategoryItem _zoosItem(String path) {
    return CategoryItem(
      image: "assets/graphics/zoos.jpg",
      title: "Zoos",
      path: path,
    );
  }

  static CategoryItem _offRoadItem(String path) {
    return CategoryItem(
      image: "assets/graphics/offroad.jpg",
      title: "Off Road Trips",
      path: path,
    );
  }

  static CategoryItem _trailsItem(String path) {
    return CategoryItem(
      image: "assets/graphics/trails.jpg",
      title: "Trails",
      path: path,
    );
  }

  static CategoryItem _rockClimbingItem(String path) {
    return CategoryItem(
      image: "assets/graphics/rock_climbing.jpg",
      title: "Rock climbing",
      path: path,
    );
  }

  static CategoryItem _waterSportsItem(String path) {
    return CategoryItem(
      image: "assets/graphics/water_sports.jpg",
      title: "Water sports",
      path: path,
    );
  }

  static CategoryItem _extremeSportsItem(String path) {
    return CategoryItem(
      image: "assets/graphics/extreme_sports.jpg",
      title: "Extreme sports",
      path: path,
    );
  }

  static CategoryItem _toursItem(String path) {
    return CategoryItem(
      image: "assets/graphics/tours.jpg",
      title: "Tours",
      path: path,
    );
  }

  static CategoryItem _hotAirItem(String path) {
    return CategoryItem(
      image: "assets/graphics/hot-air.jpg",
      title: "Hot air balloons",
      path: path,
    );
  }

  static List<CategoryItem> optionalCategoryItems({
    required AttractionsCount attractionsCount,
    required String museumsPath,
    required String wineriesPath,
    required String zoosPath,
    required String offRoadTripsPath,
    required String trailsPath,
    required String waterSportsPath,
    required String rockClimbingPath,
    required String extremeSportsPath,
    required String hotAirPath,
  }) {
    return [
      if (attractionsCount.museums > 0) _museumsItem(museumsPath),
      if (attractionsCount.wineries > 0) _wineriesItem(wineriesPath),
      if (attractionsCount.zoos > 0) _zoosItem(zoosPath),
      if (attractionsCount.offRoadTrips > 0) _offRoadItem(offRoadTripsPath),
      if (attractionsCount.trails > 0) _trailsItem(trailsPath),
      if (attractionsCount.waterSports > 0) _waterSportsItem(waterSportsPath),
      if (attractionsCount.rockClimbing > 0)
        _rockClimbingItem(rockClimbingPath),
      if (attractionsCount.extremeSports > 0)
        _extremeSportsItem(extremeSportsPath),
      if (attractionsCount.hotAirAttractions > 0) _hotAirItem(hotAirPath),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final List<CategoryItem> items = [
      _museumsItem(MuseumsScreen.routePath),
      _wineriesItem(WineriesScreen.routePath),
      _zoosItem(ZoosScreen.routePath),
      _offRoadItem(OffRoadTripsScreen.routePath),
      _trailsItem(TrailsScreen.routePath),
      _rockClimbingItem(RockClimbingListScreen.routePath),
      _waterSportsItem(WaterSportsListScreen.routePath),
      _extremeSportsItem(ExtremeSportsListScreen.routePath),
      _hotAirItem(HotAirListScreen.routePath),
      _toursItem(MuseumsScreen.routePath),
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(15),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: mainAxisSpacing,
      ),
      itemBuilder: (_, index) => items[index],
      itemCount: items.length,
    );
  }
}
