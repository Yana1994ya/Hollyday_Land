import "dart:math";

import "package:flutter/material.dart";
import "package:hollyday_land/models/location.dart";
import "package:hollyday_land/providers/location_provider.dart";
import "package:intl/intl.dart";
import "package:location/location.dart";
import "package:provider/provider.dart";

class Distance extends StatelessWidget {
  final WithLocation location;
  static final distanceFormat = NumberFormat("###.0#", "en_US");

  const Distance({Key? key, required this.location}) : super(key: key);

  static double calculateDistanceKM(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;

    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Widget distanceWidget(LocationData locationData) {
    final double distance = calculateDistanceKM(
      locationData.latitude,
      locationData.longitude,
      location.lat,
      location.long,
    );

    var distanceString = distanceFormat.format(distance);
    if (distanceString.startsWith(".")) {
      distanceString = "0" + distanceString;
    }

    return Text(
      distanceString + " km",
    );
  }

  @override
  Widget build(BuildContext context) {
    LocationProvider locationProvider = Provider.of<LocationProvider>(context);

    if (locationProvider.lastSnapshot != null &&
        locationProvider.lastSnapshot!.status == LocationStatus.recieved) {
      return distanceWidget(locationProvider.lastSnapshot!.location!);
    } else {
      return Container();
    }
  }
}
