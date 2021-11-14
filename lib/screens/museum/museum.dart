import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hollyday_land/models/favorites.dart';
import 'package:hollyday_land/models/museum/museum.dart';
import 'package:hollyday_land/models/museum/museum_short.dart';
import 'package:hollyday_land/providers/login.dart';
import 'package:hollyday_land/widgets/favorite_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MuseumScreen extends StatefulWidget {
  final MuseumShort museum;

  const MuseumScreen({Key? key, required this.museum}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MuseumScreenState();
}

class _MuseumScreenState extends State<MuseumScreen> {
  late final Future<Museum> loadingMuseum;

  @override
  void initState() {
    loadingMuseum = Museum.readMuseum(widget.museum.id);
    super.initState();
  }

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

  Widget buildMuseum(final Museum museum, BuildContext context) {
    final List<Image> images = [
      museum.mainImage == null
          ? Image.asset(
              "assets/graphics/icon.png",
              fit: BoxFit.cover,
            )
          : Image.network(
              museum.mainImage!.url,
              fit: BoxFit.cover,
            ),
      ...museum.additionalImages
          .map((image) => Image.network(image.url, fit: BoxFit.cover))
    ];

    // Trim details from url that aren't needed to
    // identify the site to a human, such as the protocol
    // used to access it.
    String prettyUrl(String original) {
      if (original.startsWith("http://"))
        original = original.substring(7);
      else if (original.startsWith("https://"))
        original = original.substring(8);

      // trim www. from begging as well
      if (original.startsWith("www.")) original = original.substring(4);

      while (original.endsWith("/"))
        original = original.substring(0, original.length - 1);

      return original;
    }

    void launchWebsite() async => await canLaunch(museum.website!)
        ? await launch(museum.website!)
        : throw 'Could not launch ${museum.website}';

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(8.0),
              child: displayImages(images, context)),
          Text(
            museum.name,
            style: Theme.of(context).textTheme.headline6,
          ),
          if (museum.website != null)
            TextButton(
              onPressed: launchWebsite,
              child: Text(prettyUrl(museum.website!)),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(museum.description),
          ),
        ],
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
                              loginProvider.signIn();
                            },
                            child: const Text("Yes"))
                      ],
                    ));
          },
          icon: Icon(Icons.favorite_outline));
    } else {
      return FutureBuilder(
        future:
            Favorites.readFavorite(loginProvider.hdToken!, widget.museum.id),
        builder: (_, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasError) {
            //scaffoldMessanger.showSnackBar(SnackBar(content: Text('Failed to read favorite status')));
            print(snapshot.error);
            return Icon(Icons.error);
          } else if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            return FavoriteButton(
                attractionId: widget.museum.id,
                initalState: snapshot.data!,
                token: loginProvider.hdToken!);
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final login = Provider.of<LoginProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.museum.name),
        actions: [
          favoriteIcon(context, login),
        ],
      ),
      body: FutureBuilder(
        future: loadingMuseum,
        builder: (_, AsyncSnapshot<Museum> snapshot) {
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
            return buildMuseum(snapshot.data!, context);
          }
        },
      ),
    );
  }
}
