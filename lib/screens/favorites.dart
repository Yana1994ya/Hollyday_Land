import "package:flutter/material.dart";
import "package:hollyday_land/models/favorites.dart";
import "package:hollyday_land/providers/login.dart";
import "package:hollyday_land/screens/profile.dart";
import "package:hollyday_land/widgets/favorites_categories_grid.dart";
import "package:provider/provider.dart";

class _LoggedInFavoritesScreen extends StatefulWidget {
  final LoginProvider loginProvider;

  const _LoggedInFavoritesScreen({Key? key, required this.loginProvider})
      : super(key: key);

  @override
  State<_LoggedInFavoritesScreen> createState() =>
      _LoggedInFavoritesScreenState();
}

class _LoggedInFavoritesScreenState extends State<_LoggedInFavoritesScreen> {
  Favorites? favorites;
  bool loading = true;
  Error? error;

  @override
  Widget build(BuildContext context) {
    if (loading == true) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Favorites"),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Favorites"),
        ),
        body: FavoritesCategoriesGrid(favorites: favorites!),
      );
    }
  }

  @override
  void initState() {
    Favorites.readFavorites(widget.loginProvider.hdToken!).then((favorites) {
      setState(() {
        this.favorites = favorites;
        loading = false;
      });
    });

    super.initState();
  }
}

class FavoritesScreen extends StatelessWidget {
  static const routePath = "/favorites";

  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    if (loginProvider.currentUser == null) {
      //reason: "Please login to see your history"
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
