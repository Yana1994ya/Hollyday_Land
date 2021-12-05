import "package:hollyday_land/models/base_attraction.dart";
import "package:hollyday_land/models/image_asset.dart";
import "package:hollyday_land/models/region.dart";

abstract class Attraction extends BaseAttraction {
  ImageAsset? get mainImage;

  Region get region;

  String get address;

  List<ImageAsset> get additionalImages;

  String? get website;

  String get description;

  String? get city;

  String? get telephone;
}
