import "package:flutter/material.dart";
import "package:hollyday_land/models/attraction.dart";
import "package:hollyday_land/models/base_attraction.dart";
import "package:hollyday_land/models/favorites.dart";
import "package:hollyday_land/providers/location_provider.dart";
import "package:hollyday_land/providers/login.dart";
import "package:hollyday_land/widgets/attraction_map.dart";
import "package:hollyday_land/widgets/description.dart";
import "package:hollyday_land/widgets/distance.dart";
import "package:hollyday_land/widgets/favorite_button.dart";
import "package:hollyday_land/widgets/image_carousel.dart";
import "package:hollyday_land/widgets/rating.dart";
import "package:provider/provider.dart";
import "package:url_launcher/url_launcher.dart";

abstract class AttractionScreen<T extends Attraction> extends StatelessWidget {
  final BaseAttraction attraction;

  const AttractionScreen({Key? key, required this.attraction})
      : super(key: key);

  static void launchUrl(String url) async =>
      await canLaunch(url) ? await launch(url) : throw "Could not launch $url";

  static void launchPhone(String number) => launchUrl("tel:" + number);

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
                Rating(rating: attraction),
                Distance(
                  location: attraction,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            if (attraction.website != null || attraction.telephone != null)
              Row(
                children: [
                  if (attraction.website != null)
                    TextButton(
                      onPressed: () {
                        launchUrl(attraction.website!);
                      },
                      child: Row(
                        children: [
                          //Icon(Icons.iron),
                          Text("Visit website")
                        ],
                      ),
                    ),
                  if (attraction.telephone != null)
                    TextButton(
                      onPressed: () {
                        launchPhone(attraction.telephone!);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone,
                            size: 16.0,
                          ),
                          Text("call")
                        ],
                      ),
                    ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            if (attraction.description.isNotEmpty)
              Description(text: attraction.description),
            SizedBox(
              width: double.infinity,
              height: 300.0,
              child: AttractionMap(
                attraction: attraction,
              ),
            )
            //
          ],
        ),
      ),
    );
  }

  static Widget favoriteIcon(
    BuildContext context,
    LoginProvider loginProvider,
    Future<bool> Function(String) initialState,
    Widget Function(String, bool) widgetFunction,
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
        future: initialState(loginProvider.hdToken!),
        builder: (_, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasError) {
            //scaffoldMessanger.showSnackBar(SnackBar(content: Text('Failed to read favorite status')));
            print(snapshot.error);
            return Icon(Icons.error);
          } else if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            return widgetFunction(
              loginProvider.hdToken!,
              snapshot.data!,
            );
          }
        },
      );
    }
  }

  Future<T> readFull();

  @override
  Widget build(BuildContext context) {
    final login = Provider.of<LoginProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(attraction.name),
        actions: [
          AttractionScreen.favoriteIcon(
            context,
            login,
            (hdToken) => Favorites.readFavorite(hdToken, attraction.id),
            (hdToken, initialState) => FavoriteButton(
              attractionId: attraction.id,
              initialState: initialState,
              token: hdToken,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share),
          )
        ],
      ),
      body: FutureBuilder(
        future: readFull(),
        builder: (_, AsyncSnapshot<T> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            login.visit(snapshot.data!.id);
            return buildAttraction(snapshot.data!, context);
          }
        },
      ),
    );
  }
}
