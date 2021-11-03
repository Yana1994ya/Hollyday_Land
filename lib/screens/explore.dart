import 'package:flutter/material.dart';
import 'package:hollyday_land/models/attraction.dart';
import 'package:hollyday_land/providers/root_categories.dart';
import 'package:hollyday_land/providers/selected_categories.dart';
import 'package:hollyday_land/widgets/attraction.dart';
import 'package:hollyday_land/widgets/categories_grid.dart';
import 'package:provider/provider.dart';

import '../models/category.dart';

class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RootCategoriesProvider rootCategoriesProvider =
        Provider.of<RootCategoriesProvider>(context);
    final SelectedCategoriesProvider selectedCategoriesProvider =
        Provider.of<SelectedCategoriesProvider>(context);

    if (rootCategoriesProvider.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (!selectedCategoriesProvider.categorySelected) {
        List<Category> allCategories = List.empty(growable: true);

        for (var root in rootCategoriesProvider.categories!) {
          allCategories.addAll(root.subCategories);
        }

        return CategoriesGrid(categories: allCategories);
      } else {
        final List<int> missingCategories =
            selectedCategoriesProvider.requiresChildernOf;

        if (missingCategories.isNotEmpty) {
          return FutureBuilder<List<Category>>(
            future: Category.fetchCategoriesFor(
              selectedCategoriesProvider.categoryIds,
              missingCategories,
            ),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                return Text("error encountered when retrieving data");
              } else if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                return CategoriesGrid(
                  categories: snapshot.data!,
                );
              }
            },
          );
        } else {
          return FutureBuilder<List<Attraction>>(
            future: Attraction.fetchAttractions(
                selectedCategoriesProvider.categoryIds),
            builder: (ctx, snapshot) {
              if (snapshot.hasError) {
                return Text("error encountered when retrieving data");
              } else if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else {
                final List<Attraction> attractions =
                    snapshot.data as List<Attraction>;

                return ListView.builder(
                  itemBuilder: (_, index) => AttractionCard(
                    attraction: attractions[index],
                  ),
                  itemCount: attractions.length,
                );
              }
            },
          );
        }
      }
    }
  }
}
