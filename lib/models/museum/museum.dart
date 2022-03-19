import "package:decimal/decimal.dart";
import "package:hollyday_land/api_server.dart";
import "package:hollyday_land/models/attraction.dart";
import "package:hollyday_land/models/image_asset.dart";
import "package:hollyday_land/models/museum/museum_domain.dart";
import "package:hollyday_land/models/region.dart";

class Museum extends Attraction {
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
  final MuseumDomain domain;

  @override
  final String? city;
  @override
  final String? telephone;

  @override
  final Decimal avgRating;
  @override
  final int ratingCount;

  Museum({
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
    required this.domain,
    required this.city,
    required this.telephone,
    required this.avgRating,
    required this.ratingCount,
  });

  factory Museum.fromJson(Map<String, dynamic> json) {
    final List<dynamic> additionalImagesJson = json["additional_images"];

    return Museum(
      id: json["id"],
      name: json["name"],
      mainImage: json["main_image"] == null
          ? null
          : ImageAsset.fromJson(json["main_image"]),
      additionalImages:
          additionalImagesJson.map((m) => ImageAsset.fromJson(m)).toList(),
      description: json["description"],
      domain: MuseumDomain.fromJson(json["domain"]),
      region: Region.fromJson(json["region"]),
      address: json["address"],
      website: json["website"],
      long: json["long"],
      lat: json["lat"],
      city: json["city"],
      telephone: json["telephone"],
      avgRating: Decimal.parse(json["avg_rating"]),
      ratingCount: json["rating_count"],
    );
  }

  static Future<Museum> readMuseum(int museumId, int ratingCacheKey) {
    return ApiServer.get("/attractions/api/museums/$museumId", "museum", {
      "rating_cache_key": [ratingCacheKey.toString()]
    }).then((data) => Museum.fromJson(data));
  }

  @override
  String toString() {
    return "Museum{id: $id, name: $name, description: $description, "
        "address: $address, website: $website, lat: $lat, long: $long, "
        "mainImage: $mainImage, additionalImages: $additionalImages, "
        "region: $region, domain: $domain}";
  }
}
