import "package:hollyday_land/models/attraction_filter.dart";

class ZooFilter extends AttractionFilter {
  @override
  final Set<int> regionIds;

  const ZooFilter({required this.regionIds});

  factory ZooFilter.empty() {
    return ZooFilter(regionIds: {});
  }
}
