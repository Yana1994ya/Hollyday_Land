import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:hollyday_land/providers/login.dart";
import "package:hollyday_land/providers/regions.dart";
import "package:hollyday_land/screens/explore.dart";
import "package:hollyday_land/screens/favorites.dart";
import "package:hollyday_land/screens/history.dart";
import "package:hollyday_land/screens/museum/favorites_museums.dart";
import "package:hollyday_land/screens/museum/history_museums.dart";
import "package:hollyday_land/screens/museum/museums.dart";
import "package:hollyday_land/screens/profile.dart";
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
        ChangeNotifierProvider(create: (_) => RegionsProvider())
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
          ProfileScreen.routePath: (_) => ProfileScreen(),
          HistoryScreen.routePath: (_) => HistoryScreen(),
          FavoritesScreen.routePath: (_) => FavoritesScreen(),
          HistoryMuseumsScreen.routePath: (_) => HistoryMuseumsScreen(),
          FavoritesMuseumsScreen.routePath: (_) => FavoritesMuseumsScreen()
        },
      ),
    );
  }
}
