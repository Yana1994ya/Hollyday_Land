import "package:hollyday_land/models/region.dart";
import "package:hollyday_land/models/water_sports/attraction_type.dart";

class WaterSportsFilterOptions {
  final List<WaterSportsAttractionType> attractionTypes;
  final List<Region> regions;

  const WaterSportsFilterOptions({
    required this.attractionTypes,
    required this.regions,
  });

  static Future<WaterSportsFilterOptions> fetch() async {
    final domains = await waterSportsAttractionTypeObjects.readTags();
    final regions = await regionObjects.readTags();

    return WaterSportsFilterOptions(attractionTypes: domains, regions: regions);
  }
}
