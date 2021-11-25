import "package:flutter/material.dart";
import "package:flutter/services.dart";
import 'package:hollyday_land/providers/location_provider.dart';
import "package:hollyday_land/providers/login.dart";
import "package:hollyday_land/providers/regions.dart";
import "package:hollyday_land/screens/explore.dart";
import "package:hollyday_land/screens/favorites.dart";
import "package:hollyday_land/screens/history.dart";
import "package:hollyday_land/screens/museum/favorites.dart";
import "package:hollyday_land/screens/museum/history.dart";
import "package:hollyday_land/screens/museum/museums.dart";
import "package:hollyday_land/screens/profile.dart";
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
        ChangeNotifierProvider(create: (_) => RegionsProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
      ],
      child: MaterialApp(
        title: _title,
        home: ExploreScreen(),
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSwatch(primarySwatch: Colors.indigo).copyWith(
            secondary: Colors.indigo[200],
          ),
        ),
        routes: {
          MuseumsScreen.routePath: (_) => MuseumsScreen(),
          WineriesScreen.routePath: (_) => WineriesScreen(),
          ZoosScreen.routePath: (_) => ZoosScreen(),
          ProfileScreen.routePath: (_) => ProfileScreen(),
          HistoryScreen.routePath: (_) => HistoryScreen(),
          FavoritesScreen.routePath: (_) => FavoritesScreen(),
          HistoryMuseumsScreen.routePath: (_) => HistoryMuseumsScreen(),
          HistoryWineriesScreen.routePath: (_) => HistoryWineriesScreen(),
          HistoryZoosScreen.routePath: (_) => HistoryZoosScreen(),
          FavoritesMuseumsScreen.routePath: (_) => FavoritesMuseumsScreen(),
          FavoritesWineriesScreen.routePath: (_) => FavoritesWineriesScreen(),
          FavoritesZoosScreen.routePath: (_) => FavoritesZoosScreen()
        },
      ),
    );
  }
}
