import "package:built_collection/built_collection.dart";
import "package:decimal/decimal.dart";
import "package:hollyday_land/models/dao/base_attraction.dart";
import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land/models/image_asset.dart";
import "package:hollyday_land/models/location.dart";
import "package:hollyday_land/models/rating.dart";
import "package:hollyday_land/models/tour/destination.dart";
import "package:hollyday_land/models/tour/package.dart";
import "package:hollyday_land/models/tour/tour_language.dart";
import "package:hollyday_land_dao/full_dao.dart";

part "tour.objects.full.dart";

@FullDao("tours", "tour")
class Tour with WithLocation, WithRating, Attraction {
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

  final BuiltList<TourDestination> destinations;
  final Package? package;
  final Decimal price;
  final TourLanguage? tourLanguage;
  final Decimal length;
  final String description;
  final bool group;

  @override
  final List<ImageAsset> additionalImages;

  Tour({
    required this.id,
    required this.name,
    required this.lat,
    required this.long,
    required this.mainImage,
    required this.additionalImages,
    required this.avgRating,
    required this.ratingCount,
    required this.package,
    required this.destinations,
    required this.price,
    required this.tourLanguage,
    required this.length,
    required this.description,
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

  factory Tour.fromJson(Map<String, dynamic> json) {
    final List<dynamic> additionalImagesJson = json["additional_images"];
    final List<dynamic> destinationsJson = json["destinations"];

    return Tour(
      id: json["id"],
      name: json["name"],
      mainImage: nullable(json, "main_image", ImageAsset.fromJson),
      additionalImages:
          additionalImagesJson.map((m) => ImageAsset.fromJson(m)).toList(),
      long: json["long"],
      lat: json["lat"],
      avgRating: Decimal.parse(json["avg_rating"]),
      ratingCount: json["rating_count"],
      destinations: BuiltList.of(
          destinationsJson.map((m) => TourDestination.fromJson(m))),
      package: nullable(json, "package", Package.fromJson),
      price: Decimal.parse(json["price"]),
      tourLanguage: nullable(json, "language", TourLanguage.fromJson),
      length: Decimal.parse(json["length"]),
      description: json["description"],
      group: json["group"],
    );
  }
}
