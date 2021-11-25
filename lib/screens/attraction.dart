import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/material.dart";
import "package:hollyday_land/models/attraction.dart";
import "package:hollyday_land/models/attraction_short.dart";
import "package:hollyday_land/models/favorites.dart";
import "package:hollyday_land/providers/location_provider.dart";
import "package:hollyday_land/providers/login.dart";
import "package:hollyday_land/widgets/description.dart";
import "package:hollyday_land/widgets/distance.dart";
import "package:hollyday_land/widgets/favorite_button.dart";
import "package:hollyday_land/widgets/rating.dart";
import "package:provider/provider.dart";
import "package:url_launcher/url_launcher.dart";

abstract class AttractionScreen<TShort extends AttractionShort,
    T extends Attraction> extends StatelessWidget {
  final AttractionShort attraction;

  const AttractionScreen({Key? key, required this.attraction})
      : super(key: key);

  Widget displayImages(final List<Image> images, BuildContext context) {
    if (images.length == 1) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          width: double.infinity,
          height: 300.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: images[0].image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else {
      return CarouselSlider(
        options: CarouselOptions(height: 300.0),
        items: images.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: i.image,
                      fit: BoxFit.cover,
                    ),
                  ));
            },
          );
        }).toList(),
      );
    }
  }

  // Trim details from url that aren't needed to
  // identify the site to a human, such as the protocol
  // used to access it.
  static String prettyUrl(String original) {
    if (original.startsWith("http://")) {
      original = original.substring(7);
    } else if (original.startsWith("https://")) {
      original = original.substring(8);
    }

    // trim www. from begging as well
    if (original.startsWith("www.")) original = original.substring(4);

    while (original.endsWith("/")) {
      original = original.substring(0, original.length - 1);
    }

    return original;
  }

  static void launchWebsite(String url) async =>
      await canLaunch(url) ? await launch(url) : throw "Could not launch $url";

  Widget buildAttraction(final T attraction, BuildContext context) {
    LocationProvider location = Provider.of<LocationProvider>(context);
    location.retrieveLocation();

    final List<Image> images = [
      attraction.mainImage == null
          ? Image.asset(
              "assets/graphics/icon.png",
              fit: BoxFit.cover,
            )
          : Image.network(
              attraction.mainImage!.url,
              fit: BoxFit.cover,
            ),
      ...attraction.additionalImages
          .map((image) => Image.network(image.url, fit: BoxFit.cover))
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            displayImages(images, context),
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
                Rating(
                  rating: 4.6,
                  count: 230,
                ),
                Distance(
                  location: attraction,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            if (attraction.website != null)
              TextButton(
                onPressed: () {
                  launchWebsite(attraction.website!);
                },
                child: Row(
                  children: [
                    //Icon(Icons.iron),
                    Text("Visit website")
                  ],
                ),
              ),
            if (attraction.description.isNotEmpty)
              Description(text: attraction.description),
          ],
        ),
      ),
    );
  }

  Widget favoriteIcon(BuildContext context, LoginProvider loginProvider) {
    //final scaffoldMessanger = ScaffoldMessenger.of(context);
    if (loginProvider.currentUser == null) {
      return IconButton(
          onPressed: () {
            //loginProvider.signIn();
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text("You are currently not logged in"),
                content: const Text(
                    "Do you wish to login to mark this museum as favorite?"),
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
      return FutureBuilder(
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
              initalState: snapshot.data!,
              token: loginProvider.hdToken!,
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
          favoriteIcon(context, login),
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
