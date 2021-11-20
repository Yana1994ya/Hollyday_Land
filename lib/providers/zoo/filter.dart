import "package:hollyday_land/models/zoo/filter.dart";
import "package:hollyday_land/providers/attraction_filter.dart";

class ZooFilterProvider extends AttractionFilterProvider<ZooFilter> {
  factory ZooFilterProvider.fromFilter(ZooFilter filter) {
    return ZooFilterProvider(regionIds: filter.regionIds);
  }

  ZooFilterProvider({required Set<int> regionIds})
      : super(regionIds: regionIds);

  @override
  ZooFilter get filter {
    return ZooFilter(regionIds: regionIds);
  }
}
