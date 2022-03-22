import "package:hollyday_land/models/extreme_sports/types.dart";
import "package:hollyday_land/models/region.dart";

class ExtremeSportsFilterOptions {
  final List<ExtremeSportsType> types;
  final List<Region> regions;

  const ExtremeSportsFilterOptions({
    required this.types,
    required this.regions,
  });

  static Future<ExtremeSportsFilterOptions> fetch() async {
    final types = await extremeSportsTypeObjects.readTags();
    final regions = await regionObjects.readTags();

    return ExtremeSportsFilterOptions(types: types, regions: regions);
  }
}
