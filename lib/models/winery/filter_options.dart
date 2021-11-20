import 'package:hollyday_land/models/attraction_filter_options.dart';
import "package:hollyday_land/models/region.dart";

class WineryFilterOptions extends AttractionFilterOptions {
  @override
  final List<Region> regions;

  const WineryFilterOptions({
    required this.regions,
  });

  static Future<WineryFilterOptions> fetch() async {
    final regions = await Region.readRegions();

    return WineryFilterOptions(regions: regions);
  }
}
