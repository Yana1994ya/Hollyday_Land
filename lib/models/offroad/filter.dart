import "package:built_collection/built_collection.dart";
import "package:hollyday_land/models/filter/attraction_filter.dart";

class OffRoadTripFilter extends AttractionFilter {
  final BuiltSet<int> regionIds;
  final BuiltSet<int> tripTypeIds;

  const OffRoadTripFilter({required this.regionIds, required this.tripTypeIds});

  factory OffRoadTripFilter.empty() {
    return OffRoadTripFilter(
        regionIds: BuiltSet.of([]), tripTypeIds: BuiltSet.of([]));
  }

  @override
  Map<String, Iterable<String>> get parameters {
    final Map<String, Iterable<String>> params = {};

    if (regionIds.isNotEmpty) {
      params["region_id"] = regionIds.map((id) => id.toString());
    }

    if (tripTypeIds.isNotEmpty) {
      params["trip_type_id"] = tripTypeIds.map((id) => id.toString());
    }

    return params;
  }

  OffRoadTripFilter withRegionIds(BuiltSet<int> newRegionIds) {
    return OffRoadTripFilter(regionIds: newRegionIds, tripTypeIds: tripTypeIds);
  }

  OffRoadTripFilter withTripTypeIds(BuiltSet<int> newTripTypeIds) {
    return OffRoadTripFilter(regionIds: regionIds, tripTypeIds: newTripTypeIds);
  }
}
