import 'package:flutter/material.dart';
import 'package:hollyday_land/models/region.dart';

class RegionsProvider extends ChangeNotifier {
  bool _isLoading = true;
  List<Region>? _regions;

  RegionsProvider() {
    Region.readRegions().then((regions) {
      _regions = regions;
      _isLoading = false;
      notifyListeners();
    });
  }

  bool get isLoading {
    return _isLoading;
  }

  List<Region>? get regions {
    if (_regions == null) {
      return null;
    } else {
      return _regions!.toList();
    }
  }
}
