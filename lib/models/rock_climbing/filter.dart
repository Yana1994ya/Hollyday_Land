import "package:hollyday_land/models/filter/attraction_filter.dart";

class RockClimbingFilter extends AttractionFilter {
  final Set<int> regionIds;
  final Set<int> attractionTypeIds;

  const RockClimbingFilter(
      {required this.regionIds, required this.attractionTypeIds});

  factory RockClimbingFilter.empty() {
    return RockClimbingFilter(regionIds: {}, attractionTypeIds: {});
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
