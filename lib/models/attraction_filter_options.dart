import "package:hollyday_land/models/region.dart";

abstract class AttractionFilterOptions {
  const AttractionFilterOptions();

  List<Region> get regions;
}
