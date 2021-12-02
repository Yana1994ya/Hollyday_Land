import "package:hollyday_land/models/attraction_filter_options.dart";
import "package:hollyday_land/models/region.dart";

class RegionFilterOptions extends AttractionFilterOptions {
  @override
  final List<Region> regions;

  const RegionFilterOptions({
    required this.regions,
  });

  static Future<RegionFilterOptions> fetch() async {
    final regions = await Region.readRegions();

    return RegionFilterOptions(regions: regions);
  }
}
