import "package:decimal/decimal.dart";
import "package:hollyday_land/api_server.dart";
import "package:hollyday_land/models/attraction_short.dart";
import "package:hollyday_land/models/image_asset.dart";
import "package:hollyday_land/models/region_short.dart";
import "package:hollyday_land/models/water_sports/attraction_type.dart";

class WaterSportsShort extends AttractionShort {
  @override
  final int id;

  @override
  final String name;

  @override
  final String address;
  @override
  final double lat;
  @override
  final double long;

  @override
  final ImageAsset? mainImage;
  @override
  final RegionShort region;
  final WaterSportsAttractionType attractionType;

  @override
  final String? city;
  @override
  final String? telephone;

  @override
  final Decimal avgRating;
  @override
  final int ratingCount;

  WaterSportsShort({
    required this.id,
    required this.name,
    required this.address,
    required this.lat,
    required this.long,
    required this.mainImage,
    required this.region,
    required this.attractionType,
    required this.city,
    required this.telephone,
    required this.avgRating,
    required this.ratingCount,
  });

  factory WaterSportsShort.fromJson(Map<String, dynamic> json) {
    return WaterSportsShort(
      id: json["id"],
      name: json["name"],
      mainImage: json["main_image"] == null
          ? null
          : ImageAsset.fromJson(json["main_image"]),
      attractionType:
          WaterSportsAttractionType.fromJson(json["attraction_type"]),
      region: RegionShort.fromJson(json["region"]),
      address: json["address"],
      long: json["long"],
      lat: json["lat"],
      city: json["city"],
      telephone: json["telephone"],
      avgRating: Decimal.parse(json["avg_rating"]),
      ratingCount: json["rating_count"],
    );
  }

  @override
  String toString() {
    return "WaterSportsShort{id: $id, name: $name, address: $address, lat: $lat, "
        "long: $long, mainImage: $mainImage, region: $region, attractionType: $attractionType}";
  }

  static List<WaterSportsShort> _mapAttraction(dynamic apiResult) {
    return (apiResult as List<dynamic>)
        .map((attraction) => WaterSportsShort.fromJson(attraction))
        .toList();
  }

  static Future<List<WaterSportsShort>> readAttractions(Map<String, Iterable<String>> parameters) {
    return ApiServer.get(
      "/attractions/api/water_sports",
      "water_sports",
      parameters,
    ).then(_mapAttraction);
  }

  static Future<List<WaterSportsShort>> readHistory(String token) {
    return ApiServer.post(
      "/attractions/api/history/water_sports",
      "water_sports",
      {"token": token},
    ).then(_mapAttraction);
  }

  static Future<List<WaterSportsShort>> readFavorites(String token,
      int cacheKey,) {
    return ApiServer.post(
      "/attractions/api/favorites/water_sports",
      "water_sports",
      {
        "token": token,
        "cache_key": cacheKey,
      },
    ).then(_mapAttraction);
  }
}
