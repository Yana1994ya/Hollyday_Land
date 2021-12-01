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

  double _calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;

    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Widget distanceWidget(LocationData locationData) {
    final double distance = _calculateDistance(locationData.latitude,
        locationData.longitude, location.lat, location.long);

    return Text(
      distanceFormat.format(distance) + " km",
    );
  }

  @override
  Widget build(BuildContext context) {
    LocationProvider location = Provider.of<LocationProvider>(context);

    if (location.lastSnapshot != null &&
        location.lastSnapshot!.status == LocationStatus.recieved) {
      return distanceWidget(location.lastSnapshot!.location!);
    } else {
      return Container();
    }
  }
}
