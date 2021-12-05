import "package:flutter/material.dart";
import "package:hollyday_land/models/filter/attraction_filter.dart";
import "package:hollyday_land/providers/filter.dart";
import "package:hollyday_land/providers/offroad/filter.dart";
import "package:hollyday_land/screens/offroad/filter.dart";

class OffRoadTripFilter extends AttractionFilter {
  final Set<int> regionIds;
  final Set<int> tripTypeIds;

  const OffRoadTripFilter({required this.regionIds, required this.tripTypeIds});

  factory OffRoadTripFilter.empty() {
    return OffRoadTripFilter(regionIds: {}, tripTypeIds: {});
  }

  @override
  FilterProvider createProvider() =>
      OffRoadTripFilterProvider(regionIds, tripTypeIds);

  @override
  MaterialPageRoute get filterPage => MaterialPageRoute(
      builder: (_) => OffRoadTripFilterScreen(currentFilter: this));

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
}
