import "package:hollyday_land/models/attraction_filter.dart";

class RegionFilter extends AttractionFilter {
  @override
  final Set<int> regionIds;

  const RegionFilter({required this.regionIds});

  factory RegionFilter.empty() {
    return RegionFilter(regionIds: {});
  }
}
