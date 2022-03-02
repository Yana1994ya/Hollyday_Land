import "package:hollyday_land/api_server.dart";
import "package:hollyday_land/models/attraction_short.dart";
import "package:hollyday_land/models/image_asset.dart";
import "package:hollyday_land/models/region_short.dart";

class WineryShort extends AttractionShort {
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

  WineryShort(
      {required this.id,
      required this.name,
      required this.address,
      required this.lat,
      required this.long,
      required this.mainImage,
      required this.region,
      required this.city,
      required this.telephone});

  factory WineryShort.fromJson(Map<String, dynamic> json) {
    return WineryShort(
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
    return "WineryShort{id: $id, name: $name, address: $address, lat: $lat, "
        "long: $long, mainImage: $mainImage, region: $region}";
  }

  static List<WineryShort> _mapWineries(dynamic apiResult) {
    return (apiResult as List<dynamic>)
        .map((winery) => WineryShort.fromJson(winery))
        .toList();
  }

  static Future<List<WineryShort>> readWineries(
      final Map<String, Iterable<String>> parameters) {
    return ApiServer.get("/attractions/api/wineries", "wineries", parameters)
        .then(_mapWineries);
  }

  static Future<List<WineryShort>> readHistory(String token) {
    return ApiServer.post(
      "/attractions/api/history/wineries",
      "wineries",
      {"token": token},
    ).then(_mapWineries);
  }

  static Future<List<WineryShort>> readFavorites(
    String token,
    int cacheKey,
  ) {
    return ApiServer.post(
      "/attractions/api/favorites/wineries",
      "wineries",
      {
        "token": token,
        "cache_key": cacheKey,
      },
    ).then(_mapWineries);
  }
}
