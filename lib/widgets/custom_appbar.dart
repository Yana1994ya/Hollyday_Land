import 'package:flutter/material.dart';
import 'package:hollyday_land/providers/selected_categories.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final bool isExplore;

  const CustomAppBar({
    Key? key,
    required this.isExplore,
  }) : super(key: key);

  Widget pageTitle(SelectedCategoriesProvider selected) {
    if (isExplore && selected.categorySelected) {
      return Text(selected.lastCategoryName);
    } else {
      return Text("Hollyday Land");
    }
  }

  Widget? leadingButton(SelectedCategoriesProvider selected) {
    if (isExplore && selected.categorySelected) {
      return BackButton(
        onPressed: selected.unSelectCategory,
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedCategoriesProvider =
        Provider.of<SelectedCategoriesProvider>(context);
    return AppBar(
      title: pageTitle(selectedCategoriesProvider),
      leading: leadingButton(selectedCategoriesProvider),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          tooltip: 'Search',
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
