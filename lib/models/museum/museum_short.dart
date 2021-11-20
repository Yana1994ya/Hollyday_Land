import "package:hollyday_land/api_server.dart";
import "package:hollyday_land/models/image_asset.dart";
import "package:hollyday_land/models/museum/filter.dart";
import "package:hollyday_land/models/museum/museum_domain.dart";
import "package:hollyday_land/models/region_short.dart";

import '../attraction_short.dart';

class MuseumShort extends AttractionShort {
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
  final MuseumDomain domain;

  MuseumShort({
    required this.id,
    required this.name,
    required this.address,
    required this.lat,
    required this.long,
    required this.mainImage,
    required this.region,
    required this.domain,
  });

  factory MuseumShort.fromJson(Map<String, dynamic> json) {
    return MuseumShort(
      id: json["id"],
      name: json["name"],
      mainImage: json["main_image"] == null
          ? null
          : ImageAsset.fromJson(json["main_image"]),
      domain: MuseumDomain.fromJson(json["domain"]),
      region: RegionShort.fromJson(json["region"]),
      address: json["address"],
      long: json["long"],
      lat: json["lat"],
    );
  }

  @override
  String toString() {
    return "MuseumShort{id: $id, name: $name, address: $address, lat: $lat, "
        "long: $long, mainImage: $mainImage, region: $region, domain: $domain}";
  }

  static List<MuseumShort> _mapMuseums(dynamic apiResult) {
    return (apiResult as List<dynamic>)
        .map((museum) => MuseumShort.fromJson(museum))
        .toList();
  }

  static Future<List<MuseumShort>> readMuseums(
      MuseumFilter museumFilter) async {
    final Map<String, Iterable<String>> parameters = {};

    if (museumFilter.regionIds.isNotEmpty) {
      parameters["region_id"] =
          museumFilter.regionIds.map((id) => id.toString());
    }

    if (museumFilter.domainIds.isNotEmpty) {
      parameters["domain_id"] =
          museumFilter.domainIds.map((id) => id.toString());
    }

    return ApiServer.get("/attractions/api/museums", "museums", parameters)
        .then(_mapMuseums);
  }

  static Future<List<MuseumShort>> readHistory(String token) async {
    return ApiServer.post(
      "/attractions/api/history/museums",
      "museums",
      {"token": token},
    ).then(_mapMuseums);
  }

  static Future<List<MuseumShort>> readFavorites(String token) async {
    return ApiServer.post(
      "/attractions/api/favorites/museums",
      "museums",
      {"token": token},
    ).then(_mapMuseums);
  }
}
