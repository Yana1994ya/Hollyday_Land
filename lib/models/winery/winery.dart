import "package:hollyday_land/api_server.dart";
import 'package:hollyday_land/models/attraction.dart';
import "package:hollyday_land/models/image_asset.dart";
import "package:hollyday_land/models/region.dart";

class Winery extends Attraction {
  @override
  final int id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String address;
  @override
  final String? website;
  final double lat;
  final double long;
  @override
  final ImageAsset? mainImage;
  @override
  final List<ImageAsset> additionalImages;
  @override
  final Region region;

  Winery({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.website,
    required this.lat,
    required this.long,
    required this.mainImage,
    required this.additionalImages,
    required this.region,
  });

  factory Winery.fromJson(Map<String, dynamic> json) {
    final List<dynamic> additionalImagesJson = json["additional_images"];

    return Winery(
      id: json["id"],
      name: json["name"],
      mainImage: json["main_image"] == null
          ? null
          : ImageAsset.fromJson(json["main_image"]),
      additionalImages:
          additionalImagesJson.map((m) => ImageAsset.fromJson(m)).toList(),
      description: json["description"],
      region: Region.fromJson(json["region"]),
      address: json["address"],
      website: json["website"],
      long: json["long"],
      lat: json["lat"],
    );
  }

  static Future<Winery> readWinery(int museumId) async {
    return ApiServer.get(
      "/attractions/api/wineries/$museumId",
      "winery",
    ).then((data) => Winery.fromJson(data));
  }

  @override
  String toString() {
    return "Winery{id: $id, name: $name, description: $description, "
        "address: $address, website: $website, lat: $lat, long: $long, "
        "mainImage: $mainImage, additionalImages: $additionalImages, "
        "region: $region}";
  }
}
