import 'package:flutter/material.dart';

import '../models/category.dart';

class RootCategoriesProvider extends ChangeNotifier {
  var _loading = true;
  List<RootCategory>? _categories;

  RootCategoriesProvider() {
    Category.fetchRootCategories().then((categories) {
      _categories = categories;
      _loading = false;

      notifyListeners();
    });
  }

  bool get isLoading {
    return _loading;
  }

  List<RootCategory>? get categories {
    if (_categories == null) {
      return null;
    } else {
      return [..._categories!];
    }
  }
}
