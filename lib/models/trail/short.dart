import "package:decimal/decimal.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:hollyday_land/models/dao/base_attraction_short.dart";
import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land/models/image_asset.dart";
import "package:hollyday_land/models/location.dart";
import "package:hollyday_land/models/rating.dart";
import "package:hollyday_land/models/trail/difficulty.dart";
import "package:hollyday_land_dao/list_dao.dart";

part "short.objects.list.dart";

@ListDao("trails")
class TrailShort with WithLocation, WithRating, AttractionShort {
  @override
  final int id;
  @override
  final String name;

  @override
  final double lat;
  @override
  final double long;

  final int length;
  final int elevationGain;

  final Difficulty difficulty;

  @override
  final ImageAsset? mainImage;

  final String ownerId;

  @override
  final Decimal avgRating;
  @override
  final int ratingCount;

  TrailShort({
    required this.id,
    required this.name,
    required this.lat,
    required this.long,
    required this.length,
    required this.elevationGain,
    required this.difficulty,
    required this.mainImage,
    required this.ownerId,
    required this.avgRating,
    required this.ratingCount,
  });

  factory TrailShort.fromJson(Map<String, dynamic> json) {
    return TrailShort(
      id: json["id"],
      name: json["name"],
      mainImage: json["main_image"] == null
          ? null
          : ImageAsset.fromJson(json["main_image"]),
      long: json["long"],
      lat: json["lat"],
      length: json["length"],
      difficulty: difficultyFromString(json["difficulty"]),
      elevationGain: json["elevation_gain"],
      ownerId: json["owner_id"],
      avgRating: Decimal.parse(json["avg_rating"]),
      ratingCount: json["rating_count"],
    );
  }

  static Future<List<TrailShort>> forBounds(LatLngBounds bounds) {
    return trailShortObjects.readAttractions({
      "lat_min": [bounds.southwest.latitude.toStringAsPrecision(10)],
      "lon_min": [bounds.southwest.longitude.toStringAsPrecision(10)],
      "lat_max": [bounds.northeast.latitude.toStringAsPrecision(10)],
      "lon_max": [bounds.northeast.longitude.toStringAsPrecision(10)]
    });
  }
}
