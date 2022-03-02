import "package:flutter/material.dart";
import "package:hollyday_land/models/attractions_count.dart";
import "package:hollyday_land/models/favorites.dart";
import "package:hollyday_land/providers/favorites_cache_key.dart";
import "package:hollyday_land/providers/login.dart";
import "package:hollyday_land/screens/profile.dart";
import "package:hollyday_land/widgets/favorites_categories_grid.dart";
import "package:provider/provider.dart";

class _LoggedInFavoritesScreen extends StatelessWidget {
  final LoginProvider loginProvider;

  const _LoggedInFavoritesScreen({required this.loginProvider});

  @override
  Widget build(BuildContext context) {
    final cacheKeyProvider = Provider.of<FavoritesCacheKey>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: FutureBuilder<AttractionsCount>(
        future: Favorites.readFavorites(
          loginProvider.hdToken!,
          cacheKeyProvider.cacheKey,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error:" + snapshot.error!.toString()),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return FavoritesCategoriesGrid(favorites: snapshot.data!);
          }
        },
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  static const routePath = "/favorites";

  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    if (loginProvider.currentUser == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Favorites"),
        ),
        body: ProfileScreen.loginBody(loginProvider),
      );
    } else {
      return _LoggedInFavoritesScreen(
        loginProvider: loginProvider,
      );
    }
  }
}
