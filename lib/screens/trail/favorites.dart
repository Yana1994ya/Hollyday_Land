import "package:flutter/material.dart";
import "package:hollyday_land/models/trail/short.dart";
import "package:hollyday_land/providers/favorites_cache_key.dart";
import "package:hollyday_land/providers/login.dart";
import "package:hollyday_land/screens/profile.dart";
import "package:hollyday_land/screens/trail/trails.dart";
import "package:provider/provider.dart";

class FavoritesTrailsScreen extends StatelessWidget {
  static const routePath = "/favorites/trails";

  @override
  Widget build(BuildContext context) {
    LoginProvider loginProvider = Provider.of<LoginProvider>(context);
    FavoritesCacheKey favoritesCacheKey =
        Provider.of<FavoritesCacheKey>(context);

    final Widget body;
    if (loginProvider.hdToken == null) {
      body = ProfileScreen.loginBody(loginProvider);
    } else {
      body = TrailsScreen.trailsWidget(TrailShort.readFavorites(
        loginProvider.hdToken!,
        favoritesCacheKey.cacheKey,
      ));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite trails"),
      ),
      body: body,
    );
  }
}
