import "package:hollyday_land/models/region_filter.dart";
import "package:hollyday_land/providers/attraction_filter.dart";

class RegionFilterProvider extends AttractionFilterProvider<RegionFilter> {
  factory RegionFilterProvider.fromFilter(RegionFilter filter) {
    return RegionFilterProvider(regionIds: filter.regionIds);
  }

  RegionFilterProvider({required Set<int> regionIds})
      : super(regionIds: regionIds);

  @override
  RegionFilter get filter {
    return RegionFilter(regionIds: regionIds);
  }
}
