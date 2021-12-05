import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:hollyday_land/api_server.dart";
import "package:hollyday_land/models/base_attraction.dart";
import "package:hollyday_land/screens/museum/museum.dart";
import "package:hollyday_land/screens/offroad/trip.dart";
import "package:hollyday_land/screens/winery/winery.dart";
import "package:hollyday_land/screens/zoo/zoo.dart";

class GenericAttraction extends BaseAttraction {
  @override
  final int id;
  @override
  final double lat;
  @override
  final double long;
  @override
  final String name;
  final String type;

  GenericAttraction({
    required this.id,
    required this.lat,
    required this.long,
    required this.name,
    required this.type,
  });

  factory GenericAttraction.fromJson(Map<String, dynamic> json) {
    return GenericAttraction(
      id: json["id"],
      lat: json["lat"],
      long: json["long"],
      name: json["name"],
      type: json["type"],
    );
  }

  static Future<List<GenericAttraction>> forBounds(LatLngBounds bounds) {
    final Map<String, Iterable<String>> params = {};
    params["lat_min"] = [bounds.southwest.latitude.toStringAsPrecision(10)];
    params["lon_min"] = [bounds.southwest.longitude.toStringAsPrecision(10)];
    params["lat_max"] = [bounds.northeast.latitude.toStringAsPrecision(10)];
    params["lon_max"] = [bounds.northeast.longitude.toStringAsPrecision(10)];

    return ApiServer.get("/attractions/api/map", "attractions", params).then(
        (values) => (values as List<dynamic>)
            .map((value) => GenericAttraction.fromJson(value))
            .toList());
  }

  Widget get page {
    if (type == "museum") {
      return MuseumScreen(attraction: this);
    } else if (type == "winery") {
      return WineryScreen(attraction: this);
    } else if (type == "zoo") {
      return ZooScreen(attraction: this);
    } else if (type == "offroad") {
      return OffRoadTripScreen(attraction: this);
    } else {
      throw Exception("couldn't resolve type: $type to page");
    }
  }
}
