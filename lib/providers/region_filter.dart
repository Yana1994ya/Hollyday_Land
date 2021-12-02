import "package:hollyday_land/models/filter/attraction_filter.dart";
import "package:hollyday_land/models/filter/region_filter.dart";
import "package:hollyday_land/providers/filter.dart";
import "package:hollyday_land/providers/region_ids.dart";

class RegionFilterProvider extends FilterProvider with RegionIds {
  final String pageTitle;

  @override
  final Set<int> regionIds;

  RegionFilterProvider(this.pageTitle, this.regionIds);

  @override
  AttractionFilter get currentState => RegionFilter(pageTitle, regionIds);
}
