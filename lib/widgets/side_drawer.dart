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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            rootCategory.category.title + ":",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ));

        rootCategory.subCategories.forEach((subCategory) {
          listWidgets.add(
            ListTile(
              title: Text(subCategory.title),
              onTap: () {
                selectCategory(subCategory);
                Navigator.of(context).pop();
              },
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
