import "package:hollyday_land/models/image_asset.dart";
import "package:hollyday_land/models/region_short.dart";

abstract class AttractionShort {
  int get id;

  String get name;

  ImageAsset? get mainImage;

  RegionShort get region;

  String get address;
}
