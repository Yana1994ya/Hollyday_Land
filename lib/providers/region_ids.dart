import "package:flutter/material.dart";
import "package:hollyday_land/models/region.dart";

mixin RegionIds on ChangeNotifier {
  Set<int> get regionIds;

  bool regionIsSelected(Region region) {
    return regionIds.contains(region.id);
  }

  void regionToggle(Region region) {
    if (regionIds.contains(region.id)) {
      regionIds.remove(region.id);
    } else {
      regionIds.add(region.id);
    }

    notifyListeners();
  }
}
