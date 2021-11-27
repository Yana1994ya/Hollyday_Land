import "package:hollyday_land/api_server.dart";
import "package:hollyday_land/models/attraction_short.dart";
import "package:hollyday_land/models/image_asset.dart";
import "package:hollyday_land/models/region_short.dart";
import "package:hollyday_land/models/zoo/filter.dart";

class ZooShort extends AttractionShort {
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

  @override
  final String? city;
  @override
  final String? telephone;

  ZooShort(
      {required this.id,
      required this.name,
      required this.address,
      required this.lat,
      required this.long,
      required this.mainImage,
      required this.region,
      required this.city,
      required this.telephone});

  factory ZooShort.fromJson(Map<String, dynamic> json) {
    return ZooShort(
      id: json["id"],
      name: json["name"],
      mainImage: json["main_image"] == null
          ? null
          : ImageAsset.fromJson(json["main_image"]),
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
    return "ZooShort{id: $id, name: $name, address: $address, lat: $lat, "
        "long: $long, mainImage: $mainImage, region: $region}";
  }

  static List<ZooShort> _mapZoos(dynamic apiResult) {
    return (apiResult as List<dynamic>)
        .map((zoo) => ZooShort.fromJson(zoo))
        .toList();
  }

  static Future<List<ZooShort>> readZoos(ZooFilter zooFilter) async {
    final Map<String, Iterable<String>> parameters = {};

    if (zooFilter.regionIds.isNotEmpty) {
      parameters["region_id"] = zooFilter.regionIds.map((id) => id.toString());
    }

    return ApiServer.get("/attractions/api/zoos", "zoos", parameters)
        .then(_mapZoos);
  }

  static Future<List<ZooShort>> readHistory(String token) async {
    return ApiServer.post(
      "/attractions/api/history/zoos",
      "zoos",
      {"token": token},
    ).then(_mapZoos);
  }

  static Future<List<ZooShort>> readFavorites(String token) async {
    return ApiServer.post(
      "/attractions/api/favorites/zoos",
      "zoos",
      {"token": token},
    ).then(_mapZoos);
  }
}
