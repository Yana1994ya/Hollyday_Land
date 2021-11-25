import "package:hollyday_land/models/image_asset.dart";
import "package:hollyday_land/models/location.dart";
import "package:hollyday_land/models/region_short.dart";

abstract class AttractionShort with WithLocation {
  int get id;

  String get name;

  ImageAsset? get mainImage;

  RegionShort get region;

  String get address;
}
