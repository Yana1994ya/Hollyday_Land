import "dart:math" as math;

import "package:csv/csv.dart";
import "package:decimal/decimal.dart";
import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:hollyday_land/models/dao/base_attraction.dart";
import "package:hollyday_land/models/dao/base_attraction_short.dart";
import "package:hollyday_land/models/filter_tag.dart";
import "package:hollyday_land/models/http_exception.dart";
import "package:hollyday_land/models/image_asset.dart";
import "package:hollyday_land/models/location.dart";
import "package:hollyday_land/models/rating.dart";
import "package:hollyday_land/models/trail/trail.dart";
import 'package:hollyday_land/providers/rating.dart';
import "package:hollyday_land/screens/attraction.dart";
import "package:http/http.dart" as http;
import "package:provider/provider.dart";

class _TrailWithPoints with WithLocation, WithRating, Attraction {
  final Trail trail;
  final List<LatLng> points;

  _TrailWithPoints({
    required this.trail,
    required this.points,
  });

  @override
  List<ImageAsset> get additionalImages => trail.additionalImages;

  @override
  Decimal get avgRating => trail.avgRating;

  @override
  int get id => trail.id;

  @override
  double get lat => trail.lat;

  @override
  double get long => trail.long;

  @override
  ImageAsset? get mainImage => trail.mainImage;

  @override
  String get name => trail.name;

  @override
  int get ratingCount => trail.ratingCount;
}

class TrailScreen extends AttractionScreen<_TrailWithPoints> {
  const TrailScreen({Key? key, required AttractionShort attraction})
      : super(key: key, attraction: attraction);

  /*void pickImage(ImageSource source) {
    setState(() {
      imageUploading = true;
    });

    // Pick an image
    ImagePicker()
        .pickImage(
      source: source,
      imageQuality: 80,
      maxWidth: 3840,
      maxHeight: 2160,
    )
        .then((picture) async {
      if (picture != null) {
        final imageId = await ImageUpload.uploadImage(picture, widget.hdToken);

        setState(() {
          images.add(imageId);
          imageUploading = false;
        });
      } else {
        setState(() {
          imageUploading = false;
        });
      }
    });
  }*/

  static Future<_TrailWithPoints> _resolvePoints(Trail trail) async {
    final uri = Uri.parse(trail.points);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<List<dynamic>> rows =
          const CsvToListConverter().convert(response.body, eol: "\n");

      if (rows.isEmpty) {
        throw Exception("given csv file is empty");
      }

      final header = rows.removeAt(0);
      final indexLatitude = header.indexOf("Latitude");

      if (indexLatitude == -1) {
        throw Exception("Latitude column is missing");
      }

      final indexLongitude = header.indexOf("Longitude");

      if (indexLongitude == -1) {
        throw Exception("Longitude column is missing");
      }

      List<LatLng> points = rows.map((row) {
        return LatLng(row[indexLatitude], row[indexLongitude]);
      }).toList();

      return _TrailWithPoints(trail: trail, points: points);
    } else {
      throw HttpException(
        "failed to load data, status: ${response.statusCode}",
      );
    }
  }

  List<Widget> getChips(ThemeData theme, String label, List<FilterTag> tags) {
    if (tags.isEmpty) {
      return [];
    } else {
      return [
        SizedBox(
          height: 5,
        ),
        Text(label),
        Wrap(
          spacing: 5,
          children: tags
              .map((tag) => Chip(
                    label: Text(
                      tag.name,
                      style: TextStyle(color: Colors.white),
                    ),
                    shape: StadiumBorder(
                      side: BorderSide(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    backgroundColor: theme.colorScheme.primary,
                  ))
              .toList(),
        ),
      ];
    }
  }

  @override
  List<Widget> extraActionButtons(
      _TrailWithPoints attraction, BuildContext context) {
    return [];
  }

  @override
  List<Widget> pageBody(_TrailWithPoints attraction, BuildContext context) {
    final theme = Theme.of(context);

    return [
      ...getChips(
        theme,
        "Activities",
        attraction.trail.activities,
      ),
      ...getChips(
        theme,
        "Attractions",
        attraction.trail.attractions,
      ),
      ...getChips(
        theme,
        "Suitabilities",
        attraction.trail.suitabilities,
      ),
      SizedBox(
        height: 5,
      ),
      _TrailMap(
        trailAndPoints: attraction,
      )
    ];
  }

  @override
  Future<_TrailWithPoints> readFull(BuildContext context) {
    final RatingCacheKey ratingCacheKey = Provider.of<RatingCacheKey>(context);

    return trailObjects
        .read(attraction.id, ratingCacheKey.cacheKey)
        .then(_resolvePoints);
  }
}

/*class TrailScreen extends StatelessWidget {
  final TrailShort trail;

  const TrailScreen({Key? key, required this.trail}) : super(key: key);

  static Future<_TrailWithPoints> _resolvePoints(Trail trail) async {
    final uri = Uri.parse(trail.points);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<List<dynamic>> rows =
          const CsvToListConverter().convert(response.body, eol: "\n");

      if (rows.isEmpty) {
        throw Exception("given csv file is empty");
      }

      final header = rows.removeAt(0);
      final indexLatitude = header.indexOf("Latitude");

      if (indexLatitude == -1) {
        throw Exception("Latitude column is missing");
      }

      final indexLongitude = header.indexOf("Longitude");

      if (indexLongitude == -1) {
        throw Exception("Longitude column is missing");
      }

      List<LatLng> points = rows.map((row) {
        return LatLng(row[indexLatitude], row[indexLongitude]);
      }).toList();

      return _TrailWithPoints(trail: trail, points: points);
    } else {
      throw HttpException(
        "failed to load data, status: ${response.statusCode}",
      );
    }
  }

  /*void pickImage(ImageSource source) {
    setState(() {
      imageUploading = true;
    });

    // Pick an image
    ImagePicker()
        .pickImage(
      source: source,
      imageQuality: 80,
      maxWidth: 3840,
      maxHeight: 2160,
    )
        .then((picture) async {
      if (picture != null) {
        final imageId = await ImageUpload.uploadImage(picture, widget.hdToken);

        setState(() {
          images.add(imageId);
          imageUploading = false;
        });
      } else {
        setState(() {
          imageUploading = false;
        });
      }
    });
  }

  Widget actionsMenu() {
    return PopupMenuButton(
      onSelected: (index) {
        if (index == 1) {
          // pickImage(ImageSource.camera);
        } else if (index == 2) {
          // pickImage(ImageSource.gallery);
        }
      },
      itemBuilder: (context) => <PopupMenuEntry<int>>[
        PopupMenuItem<int>(
          value: 1,
          child: Row(
            children: [
              SizedBox(
                child: Image.asset("assets/graphics/camera.png"),
                width: 24,
                height: 24,
              ),
              Text(" Take a picture"),
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 2,
          child: Row(
            children: [
              SizedBox(
                child: Image.asset("assets/graphics/photos.png"),
                width: 24,
                height: 24,
              ),
              Text(" Upload from gallery"),
            ],
          ),
        ),
      ],
    );
  }*/

  @override
  Widget build(BuildContext context) {
    // Ask for permission to get location, ask early to improve user experience
    Provider.of<LocationProvider>(context, listen: false).retrieveLocation();
    final TrailsCacheKey trailsCacheKey = Provider.of<TrailsCacheKey>(context);
    final login = Provider.of<LoginProvider>(context);

    print((login.userId ?? "Guest") + " == " + trail.ownerId);

    login.visit(trail.id);

    return Scaffold(
        appBar: AppBar(
          title: Text(trail.name),
          actions: [
            AttractionScreen.favoriteIcon(
              context,
              login,
              (hdToken) => Favorites.readFavorite(hdToken, trail.id),
              (hdToken, initialState) => FavoriteButton(
                attractionId: trail.id,
                initialState: initialState,
                token: hdToken,
              ),
            ),
            if (login.userId == trail.ownerId)
              TrailImageUpload(
                trailId: trail.id,
                hdToken: login.hdToken!,
              )
          ],
        ),
        body: FutureBuilder(
          future: trailObjects.read(trail.id, trailsCacheKey.cacheKey)
              .then(_resolvePoints),
          builder: (BuildContext _, AsyncSnapshot<_TrailWithPoints> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error!.toString()));
            } else if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return _TrailScreenBody(trailAndPoints: snapshot.data!);
            }
          },
        ));
  }
}*/

// Everything is loaded
class _TrailMap extends StatefulWidget {
  final _TrailWithPoints trailAndPoints;

  const _TrailMap({
    Key? key,
    required this.trailAndPoints,
  }) : super(key: key);

  @override
  State<_TrailMap> createState() => _TrailMapState();
}

class _TrailMapState extends State<_TrailMap> {
  GoogleMapController? controller;

  CameraUpdate trailCamera() {
    LatLngBounds bound = LatLngBounds(
      southwest: LatLng(
        widget.trailAndPoints.points.map((p) => p.latitude).reduce(math.min),
        widget.trailAndPoints.points.map((p) => p.longitude).reduce(math.min),
      ),
      northeast: LatLng(
        widget.trailAndPoints.points.map((p) => p.latitude).reduce(math.max),
        widget.trailAndPoints.points.map((p) => p.longitude).reduce(math.max),
      ),
    );

    return CameraUpdate.newLatLngBounds(bound, 50);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 200,
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
              target: widget.trailAndPoints.points.first, zoom: 13),
          onMapCreated: (GoogleMapController controller) {
            this.controller = controller;
            controller.animateCamera(trailCamera());
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          polylines: {
            Polyline(
              polylineId: PolylineId("trail"),
              visible: true,
              color: Colors.lightGreen,
              points: widget.trailAndPoints.points,
              width: 3,
            )
          },
        ));
  }

  @override
  void dispose() {
    if (controller != null) {
      controller!.dispose();
    }

    super.dispose();
  }
}
