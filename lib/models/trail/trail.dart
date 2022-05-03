import "package:decimal/decimal.dart";
import "package:hollyday_land/models/dao/base_attraction.dart";
import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land/models/google_user.dart";
import "package:hollyday_land/models/image_asset.dart";
import "package:hollyday_land/models/location.dart";
import "package:hollyday_land/models/rating.dart";
import "package:hollyday_land/models/trail/activity.dart";
import "package:hollyday_land/models/trail/attraction.dart";
import "package:hollyday_land/models/trail/difficulty.dart";
import "package:hollyday_land/models/trail/suitability.dart";
import "package:hollyday_land_dao/full_dao.dart";

part "trail.objects.full.dart";

@FullDao("trails", "trail")
class Trail with WithLocation, WithRating, Attraction {
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
  @override
  final List<ImageAsset> additionalImages;
  final List<TrailActivity> activities;
  final List<TrailAttraction> attractions;
  final List<TrailSuitability> suitabilities;
  final GoogleUser googleUser;
  final String points;

  @override
  final Decimal avgRating;
  @override
  final int ratingCount;

  Trail({
    required this.id,
    required this.name,
    required this.lat,
    required this.long,
    required this.length,
    required this.elevationGain,
    required this.difficulty,
    required this.mainImage,
    required this.additionalImages,
    required this.activities,
    required this.attractions,
    required this.suitabilities,
    required this.googleUser,
    required this.points,
    required this.avgRating,
    required this.ratingCount,
  });

  factory Trail.fromJson(Map<String, dynamic> json) {
    final List<dynamic> additionalImagesJson = json["additional_images"];
    final List<dynamic> activities = json["activities"];
    final List<dynamic> attractions = json["attractions"];
    final List<dynamic> suitabilities = json["suitabilities"];

    return Trail(
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
      activities:
          activities.map((json) => TrailActivity.fromJson(json)).toList(),
      attractions:
          attractions.map((json) => TrailAttraction.fromJson(json)).toList(),
      suitabilities:
          suitabilities.map((json) => TrailSuitability.fromJson(json)).toList(),
      googleUser: GoogleUser.fromJson(json["owner"]),
      points: json["points"],
      additionalImages:
          additionalImagesJson.map((m) => ImageAsset.fromJson(m)).toList(),
      avgRating: Decimal.parse(json["avg_rating"]),
      ratingCount: json["rating_count"],
    );
  }
}
