import 'package:flutter/material.dart';
import 'package:hollyday_land/models/category.dart';

class SelectedCategoriesProvider with ChangeNotifier {
  // Ids assigned by the database that unfortunatly need to be hard-coded for performance
  static const int CATEGORY_REGION = 1;
  static const int CATEGORY_ATTRACTION_TYPE = 6;

  static const List<int> ROOT_CATEGORY_IDS = [
    CATEGORY_REGION,
    CATEGORY_ATTRACTION_TYPE,
  ];
  final List<Category> _selectedCategories = List.empty(growable: true);

  SelectedCategoriesProvider();

  void selectCategory(Category category) {
    _selectedCategories.add(category);
    notifyListeners();
  }

  void unSelectCategory() {
    _selectedCategories.removeLast();
    notifyListeners();
  }

  bool get categorySelected {
    return _selectedCategories.isNotEmpty;
  }

  String get lastCategoryName {
    return _selectedCategories.last.title;
  }

  Set<int> get _activeParents {
    return _selectedCategories
        .where((element) => element.parentId != null)
        .map((element) => element.parentId!)
        .toSet();
  }

  List<int> get requiresChildernOf {
    List<int> result = List.empty(growable: true);
    Set<int> activeParentsIds = _activeParents;

    for (var rootCategoryId in ROOT_CATEGORY_IDS) {
      if (!activeParentsIds.contains(rootCategoryId)) {
        result.add(rootCategoryId);
      }
    }

    return result;
  }

  List<int> get categoryIds {
    return _selectedCategories.map((category) => category.id).toList();
  }
}
