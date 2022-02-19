import "package:hollyday_land/models/filter/attraction_filter.dart";

class WaterSportsFilter extends AttractionFilter {
  final Set<int> regionIds;
  final Set<int> attractionTypeIds;

  const WaterSportsFilter(
      {required this.regionIds, required this.attractionTypeIds});

  factory WaterSportsFilter.empty() {
    return WaterSportsFilter(regionIds: {}, attractionTypeIds: {});
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
