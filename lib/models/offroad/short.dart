import "package:hollyday_land/api_server.dart";
import "package:hollyday_land/models/attraction_short.dart";
import "package:hollyday_land/models/image_asset.dart";
import "package:hollyday_land/models/offroad/trip_type.dart";
import "package:hollyday_land/models/region_short.dart";

class OffRoadTripShort extends AttractionShort {
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
  final TripType tripType;

  @override
  final String? city;
  @override
  final String? telephone;

  OffRoadTripShort(
      {required this.id,
      required this.name,
      required this.address,
      required this.lat,
      required this.long,
      required this.mainImage,
      required this.region,
      required this.tripType,
      required this.city,
      required this.telephone});

  factory OffRoadTripShort.fromJson(Map<String, dynamic> json) {
    return OffRoadTripShort(
      id: json["id"],
      name: json["name"],
      mainImage: json["main_image"] == null
          ? null
          : ImageAsset.fromJson(json["main_image"]),
      tripType: TripType.fromJson(json["trip_type"]),
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
    return "MuseumShort{id: $id, name: $name, address: $address, lat: $lat, "
        "long: $long, mainImage: $mainImage, region: $region, tripType: $tripType}";
  }

  static List<OffRoadTripShort> _mapOffroad(dynamic apiResult) {
    return (apiResult as List<dynamic>)
        .map((offRoad) => OffRoadTripShort.fromJson(offRoad))
        .toList();
  }

  static Future<List<OffRoadTripShort>> readTrips(
      Map<String, Iterable<String>> parameters) async {
    return ApiServer.get("/attractions/api/offroad", "offroad", parameters)
        .then(_mapOffroad);
  }

  static Future<List<OffRoadTripShort>> readHistory(String token) async {
    return ApiServer.post(
      "/attractions/api/history/offroad",
      "offroad",
      {"token": token},
    ).then(_mapOffroad);
  }

  static Future<List<OffRoadTripShort>> readFavorites(
      String token, int cacheKey) async {
    return ApiServer.post(
      "/attractions/api/favorites/offroad",
      "offroad",
      {
        "token": token,
        "cache_key": cacheKey,
      },
    ).then(_mapOffroad);
  }
}
