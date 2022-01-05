import "package:hollyday_land/api_server.dart";
import "package:hollyday_land/models/image_asset.dart";
import "package:hollyday_land/models/location.dart";
import "package:hollyday_land/models/trail/difficulty.dart";

class TrailShort with WithLocation {
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

  TrailShort({
    required this.id,
    required this.name,
    required this.lat,
    required this.long,
    required this.length,
    required this.elevationGain,
    required this.difficulty,
    required this.mainImage,
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
    );
  }

  static List<TrailShort> _mapTrail(dynamic apiResult) {
    return (apiResult as List<dynamic>)
        .map((trail) => TrailShort.fromJson(trail))
        .toList();
  }

  static Future<List<TrailShort>> readTrails(
      Map<String, Iterable<String>> parameters) async {
    return ApiServer.get("/attractions/api/trails", "trails", parameters)
        .then(_mapTrail);
  }
}
