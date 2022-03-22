import "package:flutter/material.dart";
import "package:hollyday_land/models/dao/base_attraction.dart";
import "package:hollyday_land/models/dao/base_attraction_short.dart";
import "package:hollyday_land/models/favorites.dart";
import "package:hollyday_land/providers/location_provider.dart";
import "package:hollyday_land/providers/login.dart";
import "package:hollyday_land/screens/attraction_reviews.dart";
import "package:hollyday_land/widgets/distance.dart";
import "package:hollyday_land/widgets/favorite_button.dart";
import "package:hollyday_land/widgets/image_carousel.dart";
import "package:hollyday_land/widgets/rating.dart";
import "package:provider/provider.dart";

abstract class AttractionScreen<T extends Attraction> extends StatelessWidget {
  final AttractionShort attraction;

  const AttractionScreen({Key? key, required this.attraction})
      : super(key: key);

  List<Widget> pageBody(final T attraction, BuildContext context);

  List<Widget> extraActionButtons(final T attraction, BuildContext context);

  Widget buildAttraction(final T attraction, BuildContext context) {
    LocationProvider location = Provider.of<LocationProvider>(context);
    location.retrieveLocation();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ImageCarousel(
                images: ImageCarousel.collectImages(
              attraction.mainImage,
              attraction.additionalImages,
            )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  attraction.name,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  child: Rating(rating: attraction),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_ctx) {
                      return AttractionReviewsScreen(
                        attractionId: attraction.id,
                      );
                    }));
                  },
                ),
                Distance(
                  location: attraction,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            ...pageBody(attraction, context)
            //
          ],
        ),
      ),
    );
  }

  Widget _favoriteIcon(
    BuildContext context,
    LoginProvider loginProvider,
  ) {
    if (loginProvider.currentUser == null) {
      return IconButton(
          onPressed: () {
            //loginProvider.signIn();
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text("You are currently not logged in."),
                content: const Text(
                    "Do you wish to login to mark this attraction as favorite?"),
                actions: [
                  TextButton(
                      onPressed: () {
                        loginProvider.signIn().then((_) {
                          Navigator.of(context).pop();
                        });
                      },
                      child: const Text("Yes"))
                ],
              ),
            );
          },
          icon: Icon(Icons.favorite_outline));
    } else {
      return FutureBuilder<bool>(
        future: Favorites.readFavorite(loginProvider.hdToken!, attraction.id),
        builder: (_, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasError) {
            //scaffoldMessanger.showSnackBar(SnackBar(content: Text('Failed to read favorite status')));
            print(snapshot.error);
            return Icon(Icons.error);
          } else if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            return FavoriteButton(
              attractionId: attraction.id,
              initialState: snapshot.data!,
              token: loginProvider.hdToken!,
            );
          }
        },
      );
    }
  }

  Future<T> readFull(BuildContext context);

  @override
  Widget build(BuildContext context) {
    final login = Provider.of<LoginProvider>(context);

    return FutureBuilder(
        future: readFull(context),
        builder: (_, AsyncSnapshot<T> snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text(attraction.name),
              ),
              body: Center(
                child: Text(
                  snapshot.error.toString(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
            );
          } else if (!snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text(attraction.name),
                actions: [
                  _favoriteIcon(
                    context,
                    login,
                  ),
                  //...extraActionButtons(attraction, context)
                ],
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            final T fullModel = snapshot.data!;
            login.visit(snapshot.data!.id);

            return Scaffold(
              appBar: AppBar(
                title: Text(attraction.name),
                actions: [
                  _favoriteIcon(
                    context,
                    login,
                  ),
                  ...extraActionButtons(fullModel, context)
                ],
              ),
              body: buildAttraction(fullModel, context),
            );
          }
        });
  }
}
