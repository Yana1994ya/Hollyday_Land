import 'package:flutter/material.dart';
import 'package:hollyday_land/providers/root_categories.dart';
import 'package:hollyday_land/widgets/categories_grid.dart';
import 'package:provider/provider.dart';

import '../models/category.dart';

typedef void SelectCategory(Category category);

class ExploreScreen extends StatelessWidget {
  final SelectCategory selectCategory;

  const ExploreScreen({Key? key, required this.selectCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RootCategoriesProvider rootCategoriesProvider =
        Provider.of<RootCategoriesProvider>(context);

    if (rootCategoriesProvider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      List<Category> allCategories = List.empty(growable: true);

      for (var root in rootCategoriesProvider.categories!) {
        allCategories.addAll(root.subCategories);
      }

      return CategoriesGrid(
        categories: allCategories,
        selectCategory: selectCategory,
      );
    }
  }
}
