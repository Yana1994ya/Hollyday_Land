import "package:flutter/material.dart";
import "package:hollyday_land/models/museum/museum_domain.dart";
import "package:hollyday_land/models/museum/museum_filter.dart";
import "package:hollyday_land/models/region.dart";

class MuseumFilterProvider with ChangeNotifier {
  final Set<int> _regionIds;
  final Set<int> _domainIds;

  factory MuseumFilterProvider.fromFilter(MuseumFilter filter) {
    return MuseumFilterProvider(
      regionIds: filter.regionIds,
      domainIds: filter.domainIds,
    );
  }

  MuseumFilterProvider(
      {required Set<int> regionIds, required Set<int> domainIds})
      : _domainIds = domainIds,
        _regionIds = regionIds;

  toggleRegion(Region region) {
    if (_regionIds.contains(region.id)) {
      _regionIds.remove(region.id);
    } else {
      _regionIds.add(region.id);
    }

    notifyListeners();
  }

  toggleDomain(MuseumDomain domain) {
    if (_domainIds.contains(domain.id)) {
      _domainIds.remove(domain.id);
    } else {
      _domainIds.add(domain.id);
    }
    notifyListeners();
  }

  bool regionSelected(Region region) {
    return _regionIds.contains(region.id);
  }

  bool domainSelected(MuseumDomain domain) {
    return _domainIds.contains(domain.id);
  }

  MuseumFilter get filter {
    return MuseumFilter(
      regionIds: _regionIds,
      domainIds: _domainIds,
    );
  }
}
