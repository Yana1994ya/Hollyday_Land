import "package:decimal/decimal.dart";
import "package:flutter/material.dart";
import "package:hollyday_land/models/image_asset.dart";
import "package:hollyday_land/models/location.dart";
import "package:hollyday_land/models/rating.dart";
import "package:hollyday_land/models/region_short.dart";

mixin AttractionShort on WithRating, WithLocation {
  int get id;

  String get name;

  ImageAsset? get mainImage;
}

class BaseAttractionShort {
  final int id;
  final String name;
  final String address;
  final double lat;
  final double long;

  final ImageAsset? mainImage;
  final RegionShort region;

  final String? city;
  final String? telephone;

  final Decimal avgRating;
  final int ratingCount;

  const BaseAttractionShort({
    required this.id,
    required this.name,
    required this.address,
    required this.lat,
    required this.long,
    required this.mainImage,
    required this.region,
    required this.city,
    required this.telephone,
    required this.avgRating,
    required this.ratingCount,
  });

  factory BaseAttractionShort.fromJson(Map<String, dynamic> json) {
    return BaseAttractionShort(
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
      avgRating: Decimal.parse(json["avg_rating"]),
      ratingCount: json["rating_count"],
    );
  }
}

class ManagedAttractionShort with WithRating, WithLocation, AttractionShort {
  final BaseAttractionShort _base;

  const ManagedAttractionShort(this._base);

  @override
  int get id => _base.id;

  @override
  String get name => _base.name;

  String get address => _base.address;

  @override
  double get lat => _base.lat;

  @override
  double get long => _base.long;

  @override
  ImageAsset? get mainImage => _base.mainImage;

  RegionShort get region => _base.region;

  String? get city => _base.city;

  String? get telephone => _base.telephone;

  @override
  Decimal get avgRating => _base.avgRating;

  @override
  int get ratingCount => _base.ratingCount;

  @protected
  String genString(String className, [String? extra]) {
    String result = className +
        "{id: $id, name: $name, address: $address, lat: $lat, "
            "long: $long, mainImage: $mainImage, region: $region";

    if (extra != null) {
      result += ", " + extra;
    }

    return result + "}";
  }

  @override
  String toString() {
    return genString("AttractionShort");
  }
}
