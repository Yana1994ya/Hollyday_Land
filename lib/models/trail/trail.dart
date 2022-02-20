import "package:hollyday_land/api_server.dart";
import "package:hollyday_land/models/google_user.dart";
import "package:hollyday_land/models/image_asset.dart";
import "package:hollyday_land/models/location.dart";
import "package:hollyday_land/models/trail/activity.dart";
import "package:hollyday_land/models/trail/attraction.dart";
import "package:hollyday_land/models/trail/difficulty.dart";
import "package:hollyday_land/models/trail/suitability.dart";

class Trail with WithLocation {
  final String id;
  final String name;
  @override
  final double lat;
  @override
  final double long;
  final int length;
  final int elevationGain;
  final Difficulty difficulty;
  final ImageAsset? mainImage;
  final List<ImageAsset> additionalImages;
  final List<TrailActivity> activities;
  final List<TrailAttraction> attractions;
  final List<TrailSuitability> suitabilities;
  final GoogleUser googleUser;
  final String points;

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
    );
  }

  static Future<Trail> readTrail(String trailId, int cacheKey) async {
    return ApiServer.get("/attractions/api/trail/$trailId", "trail", {
      "cache_key": [cacheKey.toString()]
    }).then((data) => Trail.fromJson(data));
  }
}
