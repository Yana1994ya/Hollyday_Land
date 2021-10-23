import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/root_categories.dart';
import '../screens/explore.dart';

class SideDrawer extends StatelessWidget {
  final SelectCategory selectCategory;

  const SideDrawer({Key? key, required this.selectCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoriesProvider = Provider.of<RootCategoriesProvider>(context);

    if (categoriesProvider.isLoading) {
      return const Drawer(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      final categories = categoriesProvider.categories!;
      final List<Widget> listWidgets = List.empty(growable: true);

      categories.forEach((rootCategory) {
        listWidgets.add(Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(rootCategory.category.title),
        ));

        rootCategory.subCategories.forEach((subCategory) {
          listWidgets.add(
            ListTile(
              title: Text(subCategory.title),
              onTap: () {
                selectCategory(subCategory);
              },
            ),
          );
        });
      });

      return Drawer(
          child: SafeArea(
              child:
                  ListView(padding: EdgeInsets.zero, children: listWidgets)));
    }
  }
}
