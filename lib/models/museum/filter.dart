import "package:flutter/src/material/page.dart";
import "package:hollyday_land/models/filter/attraction_filter.dart";
import "package:hollyday_land/providers/filter.dart";
import "package:hollyday_land/providers/museum/filter.dart";
import "package:hollyday_land/screens/museum/filter.dart";

class MuseumFilter extends AttractionFilter {
  final Set<int> regionIds;
  final Set<int> domainIds;

  const MuseumFilter({required this.regionIds, required this.domainIds});

  factory MuseumFilter.empty() {
    return MuseumFilter(regionIds: {}, domainIds: {});
  }

  @override
  FilterProvider createProvider() => MuseumFilterProvider(regionIds, domainIds);

  @override
  MaterialPageRoute get filterPage => MaterialPageRoute(
      builder: (_) => MuseumsFilterScreen(currentFilter: this));

  @override
  Map<String, Iterable<String>> get parameters {
    final Map<String, Iterable<String>> params = {};

    if (regionIds.isNotEmpty) {
      params["region_id"] = regionIds.map((id) => id.toString());
    }

    if (domainIds.isNotEmpty) {
      params["domain_id"] = domainIds.map((id) => id.toString());
    }

    return params;
  }
}
