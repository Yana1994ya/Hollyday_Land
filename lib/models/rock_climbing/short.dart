import "package:hollyday_land/api_server.dart";
import "package:hollyday_land/models/attraction_short.dart";
import "package:hollyday_land/models/image_asset.dart";
import "package:hollyday_land/models/region_short.dart";
import "package:hollyday_land/models/rock_climbing/attraction_type.dart";

class RockClimbingShort extends AttractionShort {
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
  final RockClimbingAttractionType attractionType;

  @override
  final String? city;
  @override
  final String? telephone;

  RockClimbingShort(
      {required this.id,
      required this.name,
      required this.address,
      required this.lat,
      required this.long,
      required this.mainImage,
      required this.region,
      required this.attractionType,
      required this.city,
      required this.telephone});

  factory RockClimbingShort.fromJson(Map<String, dynamic> json) {
    return RockClimbingShort(
      id: json["id"],
      name: json["name"],
      mainImage: json["main_image"] == null
          ? null
          : ImageAsset.fromJson(json["main_image"]),
      attractionType:
          RockClimbingAttractionType.fromJson(json["attraction_type"]),
      region: RegionShort.fromJson(json["region"]),
      address: json["address"],
      long: json["long"],
      lat: json["lat"],
      city: json["city"],
      telephone: json["telephone"],
    );
  }

  @override
  String toString() {
    return "RockClimbingShort{id: $id, name: $name, address: $address, lat: $lat, "
        "long: $long, mainImage: $mainImage, region: $region, attractionType: $attractionType}";
  }

  static List<RockClimbingShort> _mapAttraction(dynamic apiResult) {
    return (apiResult as List<dynamic>)
        .map((attraction) => RockClimbingShort.fromJson(attraction))
        .toList();
  }

  static Future<List<RockClimbingShort>> readAttractions(
      Map<String, Iterable<String>> parameters) {
    return ApiServer.get(
      "/attractions/api/rock_climbing",
      "rock_climbing",
      parameters,
    ).then(_mapAttraction);
  }

  static Future<List<RockClimbingShort>> readHistory(String token) {
    return ApiServer.post(
      "/attractions/api/history/rock_climbing",
      "rock_climbing",
      {"token": token},
    ).then(_mapAttraction);
  }

  static Future<List<RockClimbingShort>> readFavorites(
    String token,
    int cacheKey,
  ) {
    return ApiServer.post(
      "/attractions/api/favorites/rock_climbing",
      "rock_climbing",
      {
        "token": token,
        "cache_key": cacheKey,
      },
    ).then(_mapAttraction);
  }
}
