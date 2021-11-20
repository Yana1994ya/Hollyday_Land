import "package:hollyday_land/models/attraction_filter_options.dart";
import "package:hollyday_land/models/region.dart";

class ZooFilterOptions extends AttractionFilterOptions {
  @override
  final List<Region> regions;

  const ZooFilterOptions({
    required this.regions,
  });

  static Future<ZooFilterOptions> fetch() async {
    final regions = await Region.readRegions();

    return ZooFilterOptions(regions: regions);
  }
}
