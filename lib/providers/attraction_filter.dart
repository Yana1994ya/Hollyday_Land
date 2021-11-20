import "package:flutter/material.dart";
import "package:hollyday_land/models/attraction_filter.dart";
import "package:hollyday_land/models/region.dart";

abstract class AttractionFilterProvider<T extends AttractionFilter>
    with ChangeNotifier {
  final Set<int> _regionIds;

  AttractionFilterProvider({required Set<int> regionIds})
      : _regionIds = regionIds;

  toggleRegion(Region region) {
    if (_regionIds.contains(region.id)) {
      _regionIds.remove(region.id);
    } else {
      _regionIds.add(region.id);
    }

    notifyListeners();
  }

  bool regionSelected(Region region) {
    return _regionIds.contains(region.id);
  }

  Set<int> get regionIds {
    return _regionIds.toSet();
  }

  T get filter;
}
