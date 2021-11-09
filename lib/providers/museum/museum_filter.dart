import 'package:flutter/material.dart';
import 'package:hollyday_land/models/museum/museum_domain.dart';
import 'package:hollyday_land/models/museum/museum_filter.dart';
import 'package:hollyday_land/models/region.dart';

class MuseumFilterProvider with ChangeNotifier {
  Region? _region;
  MuseumDomain? _domain;

  MuseumFilterProvider(
      {required Region? region, required MuseumDomain? domain}) {
    _region = region;
    _domain = domain;
  }

  factory MuseumFilterProvider.fromFilter(MuseumFilter filter) {
    return MuseumFilterProvider(
      region: filter.region,
      domain: filter.domain,
    );
  }

  setRegion(Region? region) {
    _region = region;
    notifyListeners();
  }

  setDomain(MuseumDomain? domain) {
    _domain = domain;
    notifyListeners();
  }

  Region? get region {
    return _region;
  }

  MuseumDomain? get domain {
    return _domain;
  }

  MuseumFilter get filter {
    return MuseumFilter(
      region: _region,
      domain: _domain,
    );
  }
}
