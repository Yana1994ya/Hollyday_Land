import 'package:flutter/material.dart';
import 'package:hollyday_land/models/category.dart';
import 'package:hollyday_land/providers/root_categories.dart';
import 'package:hollyday_land/screens/explore.dart';
import 'package:hollyday_land/widgets/category_item.dart';
import 'package:provider/provider.dart';

class CategoriesGrid extends StatelessWidget {
  final List<Category> categories;
  final SelectCategory selectCategory;

  const CategoriesGrid(
      {Key? key, required this.categories, required this.selectCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(15),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (_, index) => CategoryItem(
        categories[index],
        selectCategory,
      ),
      itemCount: categories.length,
    );
  }

  static Set<int> activeParents(List<Category> categories) {
    return categories
        .where((element) => element.parentId != null)
        .map((element) => element.parentId!)
        .toSet();
  }

  static List<int> requiresChildernOf(
      BuildContext context, List<Category> categories) {
    List<int> result = List.empty(growable: true);
    Set<int> activeParentsIds = activeParents(categories);

    final RootCategoriesProvider root =
        Provider.of<RootCategoriesProvider>(context, listen: false);
    if (root.isLoading) {
      throw Exception("root categories are not loaded");
    } else {
      root.categories!.forEach((element) {
        if (!activeParentsIds.contains(element.category.id)) {
          result.add(element.category.id);
        }
      });
    }

    return result;
  }
}
