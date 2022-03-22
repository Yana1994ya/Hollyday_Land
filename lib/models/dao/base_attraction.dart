import "package:decimal/decimal.dart";
import "package:flutter/material.dart";
import "package:hollyday_land/models/image_asset.dart";
import "package:hollyday_land/models/location.dart";
import "package:hollyday_land/models/rating.dart";
import "package:hollyday_land/models/region.dart";

mixin Attraction on WithRating, WithLocation {
  int get id;

  String get name;

  ImageAsset? get mainImage;

  List<ImageAsset> get additionalImages;
}

class BaseAttraction {
  final int id;
  final String name;
  final String description;
  final String address;
  final String? website;

  final double lat;
  final double long;

  final ImageAsset? mainImage;
  final List<ImageAsset> additionalImages;

  final Region region;

  final String? city;
  final String? telephone;

  final Decimal avgRating;
  final int ratingCount;

  const BaseAttraction({
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
    required this.city,
    required this.telephone,
    required this.avgRating,
    required this.ratingCount,
  });

  factory BaseAttraction.fromJson(Map<String, dynamic> json) {
    final List<dynamic> additionalImagesJson = json["additional_images"];

    return BaseAttraction(
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
      city: json["city"],
      telephone: json["telephone"],
      avgRating: Decimal.parse(json["avg_rating"]),
      ratingCount: json["rating_count"],
    );
  }
}

class ManagedAttraction with WithRating, WithLocation, Attraction {
  final BaseAttraction _base;

  const ManagedAttraction(this._base);

  @override
  int get id => _base.id;

  @override
  String get name => _base.name;

  String get description => _base.description;

  String get address => _base.address;

  String? get website => _base.website;

  @override
  double get lat => _base.lat;

  @override
  double get long => _base.long;

  @override
  ImageAsset? get mainImage => _base.mainImage;

  @override
  List<ImageAsset> get additionalImages => _base.additionalImages;

  Region get region => _base.region;

  String? get city => _base.city;

  String? get telephone => _base.telephone;

  @override
  Decimal get avgRating => _base.avgRating;

  @override
  int get ratingCount => _base.ratingCount;

  @protected
  String genString(String className, [String? extra]) {
    String result = className +
        "{id: $id, name: $name, description: $description, "
            "address: $address, website: $website, lat: $lat, long: $long, "
            "mainImage: $mainImage, additionalImages: $additionalImages, "
            "region: $region";

    if (extra != null) {
      result += ", " + extra;
    }

    return result + "}";
  }

  @override
  String toString() {
    return genString("Attraction");
  }
}
