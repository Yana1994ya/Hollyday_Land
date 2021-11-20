import "package:hollyday_land/api_server.dart";
import 'package:hollyday_land/models/attraction_short.dart';
import "package:hollyday_land/models/image_asset.dart";
import "package:hollyday_land/models/region_short.dart";
import 'package:hollyday_land/models/winery/filter.dart';

class WineryShort extends AttractionShort {
  final int id;

  @override
  final String name;
  @override
  final String address;
  final double lat;
  final double long;

  @override
  final ImageAsset? mainImage;
  @override
  final RegionShort region;

  WineryShort({
    required this.id,
    required this.name,
    required this.address,
    required this.lat,
    required this.long,
    required this.mainImage,
    required this.region,
  });

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
      WineryFilter wineriesFilter) async {
    final Map<String, Iterable<String>> parameters = {};

    if (wineriesFilter.regionIds.isNotEmpty) {
      parameters["region_id"] =
          wineriesFilter.regionIds.map((id) => id.toString());
    }

    return ApiServer.get("/attractions/api/wineries", "wineries", parameters)
        .then(_mapWineries);
  }

  static Future<List<WineryShort>> readHistory(String token) async {
    return ApiServer.post(
      "/attractions/api/history/wineries",
      "wineries",
      {"token": token},
    ).then(_mapWineries);
  }

  static Future<List<WineryShort>> readFavorites(String token) async {
    return ApiServer.post(
      "/attractions/api/favorites/wineries",
      "wineries",
      {"token": token},
    ).then(_mapWineries);
  }
}
