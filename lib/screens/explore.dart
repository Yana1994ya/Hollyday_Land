import "package:flutter/material.dart";
import "package:hollyday_land/models/map_objects.dart";
import "package:hollyday_land/providers/login.dart";
import "package:hollyday_land/screens/favorites.dart";
import "package:hollyday_land/screens/history.dart";
import "package:hollyday_land/screens/map.dart";
import "package:hollyday_land/screens/profile.dart";
import "package:hollyday_land/screens/search.dart";
import "package:hollyday_land/widgets/categories_grid.dart";
import "package:provider/provider.dart";

class ExploreScreen extends StatelessWidget {
  Widget drawer(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final login = Provider.of<LoginProvider>(context);

    return Drawer(
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage("assets/graphics/drawer-background.png"),
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter),
          ),
          child: ListView(
            children: [
              login.currentUser == null
                  ? ListTile(
                      leading: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: ProfileScreen.userImage(null),
                        ),
                      ),
                      title: Text("Hello Guest"),
                    )
                  : ListTile(
                      leading: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: ProfileScreen.userImage(
                              login.currentUser!.photoUrl),
                        ),
                      ),
                      title: Text("Hello " + login.currentUser!.displayName!),
                      subtitle: Text(login.currentUser!.email),
                    ),
              Divider(),
              InkWell(
                highlightColor: colorScheme.secondary,
                child: ListTile(
                  leading: Icon(
                    Icons.favorite,
                    color: colorScheme.primary,
                  ),
                  title: Text("Favorites"),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(FavoritesScreen.routePath);
                },
              ),
              InkWell(
                highlightColor: colorScheme.secondary,
                child: ListTile(
                  leading: Icon(
                    Icons.navigation,
                    color: colorScheme.primary,
                  ),
                  title: Text("Map"),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    MapScreen.routePath,
                    arguments: MapObjects.attractions,
                  );
                },
              ),
              InkWell(
                highlightColor: colorScheme.secondary,
                child: ListTile(
                  leading: Icon(
                    Icons.history,
                    color: colorScheme.primary,
                  ),
                  title: Text("History"),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(HistoryScreen.routePath);
                },
              ),
              InkWell(
                highlightColor: colorScheme.secondary,
                child: ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    color: colorScheme.primary,
                  ),
                  title: Text("Profile"),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(ProfileScreen.routePath);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(SearchScreen.routePath);
              },
              icon: Icon(Icons.search)),
        ],
      ),
      body: CategoriesGrid(),
      drawer: drawer(context),
    );
  }
}
