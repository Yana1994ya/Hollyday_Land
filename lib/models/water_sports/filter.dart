import "package:built_collection/built_collection.dart";
import "package:copy_with_extension/copy_with_extension.dart";
import "package:hollyday_land/models/filter/attraction_filter.dart";

part "filter.g.dart";

@CopyWith()
class WaterSportsFilter extends AttractionFilter {
  final BuiltSet<int> regionIds;
  final BuiltSet<int> attractionTypeIds;

  const WaterSportsFilter(
      {required this.regionIds, required this.attractionTypeIds});

  factory WaterSportsFilter.empty() {
    return WaterSportsFilter(
        regionIds: BuiltSet.of([]), attractionTypeIds: BuiltSet.of([]));
  }

  @override
  Map<String, Iterable<String>> get parameters {
    final Map<String, Iterable<String>> params = {};

    if (regionIds.isNotEmpty) {
      params["region_id"] = regionIds.map((id) => id.toString());
    }

    if (attractionTypeIds.isNotEmpty) {
      params["attraction_type_id"] =
          attractionTypeIds.map((id) => id.toString());
    }

    return params;
  }
}
