import 'package:flutter/material.dart';
import 'package:hollyday_land/models/museum/museum_domain.dart';
import 'package:hollyday_land/models/museum/museum_filter.dart';
import 'package:hollyday_land/models/region.dart';

class MuseumFilterProvider with ChangeNotifier {
  final Set<int> _regions;
  final Set<int> _domains;

  factory MuseumFilterProvider.fromFilter(MuseumFilter filter) {
    return MuseumFilterProvider(
      regions: filter.regions,
      domains: filter.domains,
    );
  }

  MuseumFilterProvider({required Set<int> regions, required Set<int> domains})
      : _domains = domains,
        _regions = regions;

  toggleRegion(Region region) {
    if(_regions.contains(region.id)){
      _regions.remove(region.id);
    } else {
      _regions.add(region.id);
    }

    notifyListeners();
  }

  toggleDomain(MuseumDomain domain) {
    if(_domains.contains(domain.id)){
      _domains.remove(domain.id);
    } else {
      _domains.add(domain.id);
    }
    notifyListeners();
  }

  bool regionSelected(Region region){
    return _regions.contains(region.id);
  }

  bool domainSelected(MuseumDomain domain){
    return _domains.contains(domain.id);
  }

  MuseumFilter get filter {
    return MuseumFilter(
      regions: _regions,
      domains: _domains,
    );
  }
}
