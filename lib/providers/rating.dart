import "package:flutter/material.dart";

class RatingCacheKey extends ChangeNotifier {
  int _cacheKey = 0;

  int get cacheKey {
    return _cacheKey;
  }

  void refresh() {
    _cacheKey += 1;
    notifyListeners();
  }
}
