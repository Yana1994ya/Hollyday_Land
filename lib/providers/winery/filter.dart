import "package:hollyday_land/models/winery/filter.dart";
import "package:hollyday_land/providers/attraction_filter.dart";

class WineryFilterProvider extends AttractionFilterProvider<WineryFilter> {
  factory WineryFilterProvider.fromFilter(WineryFilter filter) {
    return WineryFilterProvider(regionIds: filter.regionIds);
  }

  WineryFilterProvider({required Set<int> regionIds})
      : super(regionIds: regionIds);

  @override
  WineryFilter get filter {
    return WineryFilter(regionIds: regionIds);
  }
}
