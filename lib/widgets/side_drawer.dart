import 'package:flutter/material.dart';
import 'package:hollyday_land/providers/selected_categories.dart';
import 'package:provider/provider.dart';

import '../providers/root_categories.dart';

class SideDrawer extends StatelessWidget {
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
        // Add title for root category
        listWidgets.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            rootCategory.category.title + ":",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ));

        // Add all the sub category buttons
        rootCategory.subCategories.forEach((subCategory) {
          listWidgets.add(
            InkWell(
              child: ListTile(
                title: Text(subCategory.title),
              ),
              onTap: () {
                Provider.of<SelectedCategoriesProvider>(context, listen: false)
                    .selectCategory(subCategory);
                Navigator.of(context).pop();
              },
              highlightColor: Theme.of(context).colorScheme.secondary,
            ),
          );
        });
      });

      return Drawer(
          child: Column(
        children: [
          AppBar(
            title: const Text('Categories:'),
            automaticallyImplyLeading: false,
          ),
          Expanded(
            child: ListView(
              children: listWidgets,
            ),
          ),
        ],
      ));
    }
  }
}
