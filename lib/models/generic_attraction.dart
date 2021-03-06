import "package:decimal/decimal.dart";
import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:hollyday_land/api_server.dart";
import "package:hollyday_land/models/dao/base_attraction_short.dart";
import "package:hollyday_land/models/image_asset.dart";
import "package:hollyday_land/models/location.dart";
import "package:hollyday_land/models/map_objects.dart";
import "package:hollyday_land/models/rating.dart";
import "package:hollyday_land/screens/extreme_sports/item.dart";
import "package:hollyday_land/screens/hot_air/hot_air.dart";
import "package:hollyday_land/screens/museum/museum.dart";
import "package:hollyday_land/screens/offroad/trip.dart";
import "package:hollyday_land/screens/rock_climbing/item.dart";
import "package:hollyday_land/screens/tour/tour.dart";
import "package:hollyday_land/screens/trail/trail.dart";
import "package:hollyday_land/screens/water_sports/item.dart";
import "package:hollyday_land/screens/winery/winery.dart";
import "package:hollyday_land/screens/zoo/zoo.dart";

class GenericAttraction with WithRating, WithLocation, AttractionShort {
  @override
  final int id;
  @override
  final double lat;
  @override
  final double long;
  @override
  final String name;

  final String type;

  @override
  final Decimal avgRating;
  @override
  final int ratingCount;

  @override
  final ImageAsset? mainImage;

  GenericAttraction({
    required this.id,
    required this.lat,
    required this.long,
    required this.name,
    required this.type,
    required this.avgRating,
    required this.ratingCount,
    required this.mainImage,
  });

  factory GenericAttraction.fromJson(Map<String, dynamic> json) {
    return GenericAttraction(
      id: json["id"],
      lat: json["lat"],
      long: json["long"],
      name: json["name"],
      type: json["type"],
      avgRating: Decimal.parse(json["avg_rating"]),
      ratingCount: json["rating_count"],
      mainImage: json["main_image"] == null
          ? null
          : ImageAsset.fromJson(json["main_image"]),
    );
  }

  static Future<List<GenericAttraction>> forBounds(
      LatLngBounds bounds, MapObjectTypes objects) {
    final Map<String, Iterable<String>> params = {};
    params["lat_min"] = [bounds.southwest.latitude.toStringAsPrecision(10)];
    params["lon_min"] = [bounds.southwest.longitude.toStringAsPrecision(10)];
    params["lat_max"] = [bounds.northeast.latitude.toStringAsPrecision(10)];
    params["lon_max"] = [bounds.northeast.longitude.toStringAsPrecision(10)];

    if (objects == MapObjectTypes.attractions) {
      params["objects"] = ["attractions"];
    } else {
      params["objects"] = ["trails"];
    }

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
    } else if (type == "trail") {
      return TrailScreen(attraction: this);
    } else if (type == "rock_climbing") {
      return RockClimbingItemScreen(attraction: this);
    } else if (type == "water_sports") {
      return WaterSportsItemScreen(attraction: this);
    } else if (type == "extreme_sports") {
      return ExtremeSportsItemScreen(attraction: this);
    } else if (type == "hot_air") {
      return HotAirScreen(attraction: this);
    } else if (type == "tour") {
      return TourScreen(short: this);
    } else {
      throw Exception("couldn't resolve type: $type to page");
    }
  }

  @override
  bool get shouldDisplayLocation => type != "tour";
}
