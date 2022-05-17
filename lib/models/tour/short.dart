import "package:decimal/decimal.dart";
import "package:hollyday_land/models/dao/base_attraction_short.dart";
import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land/models/image_asset.dart";
import "package:hollyday_land/models/location.dart";
import "package:hollyday_land/models/rating.dart";
import "package:hollyday_land/models/tour/package.dart";
import "package:hollyday_land/models/tour/tour_language.dart";
import "package:hollyday_land_dao/list_dao.dart";

part "short.objects.list.dart";

@ListDao("tours")
class TourShort with WithLocation, WithRating, AttractionShort {
  @override
  final int id;
  @override
  final String name;

  @override
  final double lat;
  @override
  final double long;

  @override
  final ImageAsset? mainImage;

  @override
  final Decimal avgRating;
  @override
  final int ratingCount;

  final Package? package;
  final Decimal price;
  final TourLanguage? tourLanguage;
  final Decimal length;

  final bool group;

  TourShort({
    required this.id,
    required this.name,
    required this.lat,
    required this.long,
    required this.mainImage,
    required this.avgRating,
    required this.ratingCount,
    required this.package,
    required this.price,
    required this.tourLanguage,
    required this.length,
    required this.group,
  });

  static T? nullable<T>(Map<String, dynamic> json, String key,
      T Function(Map<String, dynamic>) mapFunction) {
    if (json[key] == null) {
      return null;
    } else {
      return mapFunction(json[key]);
    }
  }

  factory TourShort.fromJson(Map<String, dynamic> json) {
    return TourShort(
      id: json["id"],
      name: json["name"],
      mainImage: nullable(json, "main_image", ImageAsset.fromJson),
      long: json["long"],
      lat: json["lat"],
      avgRating: Decimal.parse(json["avg_rating"]),
      ratingCount: json["rating_count"],
      package: nullable(json, "package", Package.fromJson),
      price: Decimal.parse(json["price"]),
      tourLanguage: nullable(json, "language", TourLanguage.fromJson),
      length: Decimal.parse(json["length"]),
      group: json["group"],
    );
  }

  @override
  bool get shouldDisplayLocation => false;
}
