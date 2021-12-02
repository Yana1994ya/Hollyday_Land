import "package:flutter/material.dart";
import "package:hollyday_land/models/filter/attraction_filter.dart";
import "package:hollyday_land/providers/filter.dart";
import "package:hollyday_land/screens/region_filter.dart";

class RegionFilter extends AttractionFilter {
  final String pageTitle;
  final Set<int> regionIds;

  const RegionFilter(this.pageTitle, this.regionIds);

  @override
  FilterProvider createProvider() {
    // TODO: implement createProvider
    throw UnimplementedError();
  }

  @override
  MaterialPageRoute get filterPage => MaterialPageRoute(
      builder: (_) =>
          RegionFilterScreen(currentFilter: this, pageTitle: pageTitle));

  @override
  Map<String, Iterable<String>> get parameters {
    final Map<String, Iterable<String>> params = {};

    if (regionIds.isNotEmpty) {
      params["region_id"] = regionIds.map((id) => id.toString());
    }

    return params;
  }
}
