import "package:hollyday_land/models/base_attraction.dart";
import "package:hollyday_land/models/image_asset.dart";
import "package:hollyday_land/models/region_short.dart";

abstract class AttractionShort extends BaseAttraction {
  ImageAsset? get mainImage;

  RegionShort get region;

  String get address;

  String? get city;

  String? get telephone;
}
