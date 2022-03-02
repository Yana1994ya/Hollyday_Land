import "package:hollyday_land/api_server.dart";
import "package:hollyday_land/models/attraction.dart";
import "package:hollyday_land/models/image_asset.dart";
import "package:hollyday_land/models/region.dart";
import "package:hollyday_land/models/rock_climbing/attraction_type.dart";

class RockClimbingItem extends Attraction {
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
  @override
  final double lat;
  @override
  final double long;
  @override
  final ImageAsset? mainImage;
  @override
  final List<ImageAsset> additionalImages;
  @override
  final Region region;
  final RockClimbingAttractionType attractionType;

  @override
  final String? city;
  @override
  final String? telephone;

  RockClimbingItem(
      {required this.id,
      required this.name,
      required this.description,
      required this.address,
      required this.website,
      required this.lat,
      required this.long,
      required this.mainImage,
      required this.additionalImages,
      required this.region,
      required this.attractionType,
      required this.city,
      required this.telephone});

  factory RockClimbingItem.fromJson(Map<String, dynamic> json) {
    final List<dynamic> additionalImagesJson = json["additional_images"];

    return RockClimbingItem(
      id: json["id"],
      name: json["name"],
      mainImage: json["main_image"] == null
          ? null
          : ImageAsset.fromJson(json["main_image"]),
      additionalImages:
          additionalImagesJson.map((m) => ImageAsset.fromJson(m)).toList(),
      description: json["description"],
      attractionType:
          RockClimbingAttractionType.fromJson(json["attraction_type"]),
      region: Region.fromJson(json["region"]),
      address: json["address"],
      website: json["website"],
      long: json["long"],
      lat: json["lat"],
      city: json["city"],
      telephone: json["telephone"],
    );
  }

  static Future<RockClimbingItem> readAttraction(int attractionId) {
    return ApiServer.get(
      "/attractions/api/rock_climbing/$attractionId",
      "rock_climbing",
    ).then((data) => RockClimbingItem.fromJson(data));
  }

  @override
  String toString() {
    return "RockClimbingItem{id: $id, name: $name, description: $description, "
        "address: $address, website: $website, lat: $lat, long: $long, "
        "mainImage: $mainImage, additionalImages: $additionalImages, "
        "region: $region, attractionType: $attractionType}";
  }
}
