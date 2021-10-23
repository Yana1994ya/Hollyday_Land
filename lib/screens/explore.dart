import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/category.dart';
import '../providers/root_categories.dart';
import '../widgets/category_item.dart';

typedef void SelectCategory(Category category);

class ExploreScreen extends StatelessWidget {
  final SelectCategory selectCategory;

  const ExploreScreen({Key? key, required this.selectCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoriesProvider = Provider.of<RootCategoriesProvider>(context);

    if (categoriesProvider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      final categories = categoriesProvider.categories!;

      List<Widget> categoryWidget = categories
          .expand((r) => r.subCategories
              .map((s) => CategoryItem(s, () => selectCategory(s)))
              .toList())
          .toList();

      return GridView(
        padding: const EdgeInsets.all(15),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: categoryWidget,
      );
    }
  }
}
