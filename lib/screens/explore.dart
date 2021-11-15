import "package:flutter/material.dart";
import "package:hollyday_land/providers/login.dart";
import "package:hollyday_land/screens/favorites.dart";
import "package:hollyday_land/screens/history.dart";
import "package:hollyday_land/screens/profile.dart";
import "package:hollyday_land/widgets/categories_grid.dart";
import "package:provider/provider.dart";

class ExploreScreen extends StatelessWidget {
  Widget drawer(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final login = Provider.of<LoginProvider>(context);

    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            login.currentUser == null || login.currentUser!.photoUrl == null
                ? ListTile(
                    leading: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: ExactAssetImage("assets/graphics/icon.png"),
                          fit: BoxFit.fill,
                        ),
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
                        image: DecorationImage(
                          image: NetworkImage(login.currentUser!.photoUrl!),
                          fit: BoxFit.fill,
                        ),
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
              onTap: () {},
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
      ),
      body: CategoriesGrid(),
      drawer: drawer(context),
    );
  }
}
