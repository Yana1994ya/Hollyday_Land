import "package:built_collection/built_collection.dart";
import "package:hollyday_land/models/filter/attraction_filter.dart";

class RegionFilter extends AttractionFilter {
  final BuiltSet<int> regionIds;

  const RegionFilter(this.regionIds);

  @override
  Map<String, Iterable<String>> get parameters {
    final Map<String, Iterable<String>> params = {};

    if (regionIds.isNotEmpty) {
      params["region_id"] = regionIds.map((id) => id.toString());
    }

    return params;
  }

  static RegionFilter empty() {
    return RegionFilter(BuiltSet.of([]));
  }
}
