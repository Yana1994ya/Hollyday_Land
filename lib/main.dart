import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:hollyday_land/providers/favorites_cache_key.dart";
import "package:hollyday_land/providers/location_provider.dart";
import "package:hollyday_land/providers/login.dart";
import "package:hollyday_land/providers/trail/cache_key.dart";
import "package:hollyday_land/screens/explore.dart";
import "package:hollyday_land/screens/favorites.dart";
import "package:hollyday_land/screens/history.dart";
import "package:hollyday_land/screens/map.dart";
import "package:hollyday_land/screens/museum/favorites.dart";
import "package:hollyday_land/screens/museum/history.dart";
import "package:hollyday_land/screens/museum/museums.dart";
import "package:hollyday_land/screens/offroad/favorites.dart";
import "package:hollyday_land/screens/offroad/history.dart";
import "package:hollyday_land/screens/offroad/trips.dart";
import "package:hollyday_land/screens/profile.dart";
import "package:hollyday_land/screens/rock_climbing/list.dart";
import "package:hollyday_land/screens/trail/record.dart";
import "package:hollyday_land/screens/trail/trails.dart";
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
        ChangeNotifierProvider(create: (_) => TrailsCacheKey()),
        ChangeNotifierProvider(create: (_) => FavoritesCacheKey()),
      ],
      child: MaterialApp(
        title: _title,
        home: ExploreScreen(),
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
          HistoryMuseumsScreen.routePath: (_) => HistoryMuseumsScreen(),
          HistoryWineriesScreen.routePath: (_) => HistoryWineriesScreen(),
          HistoryZoosScreen.routePath: (_) => HistoryZoosScreen(),
          FavoritesMuseumsScreen.routePath: (_) => FavoritesMuseumsScreen(),
          FavoritesWineriesScreen.routePath: (_) => FavoritesWineriesScreen(),
          FavoritesZoosScreen.routePath: (_) => FavoritesZoosScreen(),
          RockClimbingListScreen.routePath: (_) => RockClimbingListScreen(),
          WaterSportsListScreen.routePath: (_) => WaterSportsListScreen(),
          MapScreen.routePath: (_) => MapScreen(),
          OffRoadTripsScreen.routePath: (_) => OffRoadTripsScreen(),
          FavoritesOffRoadTripsScreen.routePath: (_) =>
              FavoritesOffRoadTripsScreen(),
          HistoryOffRoadTripsScreen.routePath: (_) =>
              HistoryOffRoadTripsScreen(),
          TrailRecordScreen.routePath: (_) => TrailRecordScreen()
        },
      ),
    );
  }
}
