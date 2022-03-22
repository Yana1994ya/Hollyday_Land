import "package:hollyday_land/models/region.dart";
import "package:hollyday_land/models/rock_climbing/attraction_type.dart";

class RockClimbingFilterOptions {
  final List<RockClimbingAttractionType> attractionTypes;
  final List<Region> regions;

  const RockClimbingFilterOptions({
    required this.attractionTypes,
    required this.regions,
  });

  static Future<RockClimbingFilterOptions> fetch() async {
    final attractionTypes = await rockClimbingAttractionTypeObjects.readTags();
    final regions = await regionObjects.readTags();

    return RockClimbingFilterOptions(
      attractionTypes: attractionTypes,
      regions: regions,
    );
  }
}
