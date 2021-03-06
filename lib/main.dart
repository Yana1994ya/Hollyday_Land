import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:hollyday_land/providers/cache_key.dart";
import "package:hollyday_land/providers/favorites_cache_key.dart";
import "package:hollyday_land/providers/location_provider.dart";
import "package:hollyday_land/providers/login.dart";
import "package:hollyday_land/screens/explore.dart";
import "package:hollyday_land/screens/extreme_sports/favorites.dart";
import "package:hollyday_land/screens/extreme_sports/history.dart";
import "package:hollyday_land/screens/extreme_sports/list.dart";
import "package:hollyday_land/screens/favorites.dart";
import "package:hollyday_land/screens/history.dart";
import "package:hollyday_land/screens/hot_air/favorites.dart";
import "package:hollyday_land/screens/hot_air/history.dart";
import "package:hollyday_land/screens/hot_air/hot_air_list.dart";
import "package:hollyday_land/screens/museum/favorites.dart";
import "package:hollyday_land/screens/museum/history.dart";
import "package:hollyday_land/screens/museum/museums.dart";
import "package:hollyday_land/screens/offroad/favorites.dart";
import "package:hollyday_land/screens/offroad/history.dart";
import "package:hollyday_land/screens/offroad/trips.dart";
import "package:hollyday_land/screens/profile.dart";
import "package:hollyday_land/screens/reservations.dart";
import "package:hollyday_land/screens/rock_climbing/favorites.dart";
import "package:hollyday_land/screens/rock_climbing/history.dart";
import "package:hollyday_land/screens/rock_climbing/list.dart";
import "package:hollyday_land/screens/search.dart";
import 'package:hollyday_land/screens/tour/favorites.dart';
import 'package:hollyday_land/screens/tour/history.dart';
import "package:hollyday_land/screens/tour/tours.dart";
import "package:hollyday_land/screens/trail/favorites.dart";
import "package:hollyday_land/screens/trail/history.dart";
import "package:hollyday_land/screens/trail/record.dart";
import "package:hollyday_land/screens/trail/trails.dart";
import "package:hollyday_land/screens/water_sports/favorites.dart";
import "package:hollyday_land/screens/water_sports/history.dart";
import "package:hollyday_land/screens/water_sports/list.dart";
import "package:hollyday_land/screens/winery/favorites.dart";
import "package:hollyday_land/screens/winery/history.dart";
import "package:hollyday_land/screens/winery/wineries.dart";
import "package:hollyday_land/screens/zoo/favorites.dart";
import "package:hollyday_land/screens/zoo/history.dart";
import "package:hollyday_land/screens/zoo/zoos.dart";
import "package:provider/provider.dart";

void main() {
  // Required for login
  WidgetsFlutterBinding();
  // Prevent landscape mode, not supported for this app.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = "Hollyday Land";

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesCacheKey()),
        ChangeNotifierProvider(create: (_) => CacheKey()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: _title,
        home: ExploreScreen(),
        //home: TourThemeSelection(),
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSwatch(primarySwatch: Colors.indigo).copyWith(
            secondary: Colors.indigo[200],
          ),
          fontFamily: "Nunito",
        ),
        routes: {
          MuseumsScreen.routePath: (_) => MuseumsScreen(),
          WineriesScreen.routePath: (_) => WineriesScreen(),
          ZoosScreen.routePath: (_) => ZoosScreen(),
          TrailsScreen.routePath: (_) => TrailsScreen(),
          ProfileScreen.routePath: (_) => ProfileScreen(),
          HistoryScreen.routePath: (_) => HistoryScreen(),
          FavoritesScreen.routePath: (_) => FavoritesScreen(),
          ToursScreen.routePath: (_) => ToursScreen(),
          HistoryMuseumsScreen.routePath: (_) => HistoryMuseumsScreen(),
          HistoryWineriesScreen.routePath: (_) => HistoryWineriesScreen(),
          HistoryZoosScreen.routePath: (_) => HistoryZoosScreen(),
          HistoryTrailsScreen.routePath: (_) => HistoryTrailsScreen(),
          HistoryWaterSportsScreen.routePath: (_) => HistoryWaterSportsScreen(),
          HistoryRockClimbingScreen.routePath: (_) =>
              HistoryRockClimbingScreen(),
          FavoritesMuseumsScreen.routePath: (_) => FavoritesMuseumsScreen(),
          FavoritesWineriesScreen.routePath: (_) => FavoritesWineriesScreen(),
          FavoritesZoosScreen.routePath: (_) => FavoritesZoosScreen(),
          FavoritesOffRoadTripsScreen.routePath: (_) =>
              FavoritesOffRoadTripsScreen(),
          FavoritesTrailsScreen.routePath: (_) => FavoritesTrailsScreen(),
          FavoritesWaterSportsScreen.routePath: (_) =>
              FavoritesWaterSportsScreen(),
          FavoritesRockClimbingScreen.routePath: (_) =>
              FavoritesRockClimbingScreen(),
          FavoritesToursScreen.routePath: (_) => FavoritesToursScreen(),
          RockClimbingListScreen.routePath: (_) => RockClimbingListScreen(),
          WaterSportsListScreen.routePath: (_) => WaterSportsListScreen(),
          ExtremeSportsListScreen.routePath: (_) => ExtremeSportsListScreen(),
          OffRoadTripsScreen.routePath: (_) => OffRoadTripsScreen(),
          HistoryOffRoadTripsScreen.routePath: (_) =>
              HistoryOffRoadTripsScreen(),
          TrailRecordScreen.routePath: (_) => TrailRecordScreen(),
          HistoryExtremeSportsScreen.routePath: (_) =>
              HistoryExtremeSportsScreen(),
          FavoritesExtremeSportsScreen.routePath: (_) =>
              FavoritesExtremeSportsScreen(),
          SearchScreen.routePath: (_) => SearchScreen(),
          HotAirListScreen.routePath: (_) => HotAirListScreen(),
          FavoritesHotAirScreen.routePath: (_) => FavoritesHotAirScreen(),
          HistoryHotAirScreen.routePath: (_) => HistoryHotAirScreen(),
          HistoryToursScreen.routePath: (_) => HistoryToursScreen(),
          ReservationsScreen.routePath: (_) => ReservationsScreen(),
        },
      ),
    );
  }
}
