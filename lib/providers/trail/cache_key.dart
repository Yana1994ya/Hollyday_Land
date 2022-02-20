import "dart:math";

import "package:flutter/material.dart";

class TrailsCacheKey extends ChangeNotifier {
  static const maxCacheKey = 1000000;
  var _cacheKey = Random().nextInt(maxCacheKey);

  int get cacheKey {
    return _cacheKey;
  }

  void refresh() {
    notifyListeners();
    _cacheKey = Random().nextInt(maxCacheKey);
  }
}
