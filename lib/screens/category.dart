import 'package:flutter/material.dart';
import 'package:hollyday_land/widgets/attraction.dart';
import 'package:hollyday_land/widgets/categories_grid.dart';

import '../models/attraction.dart';
import '../models/category.dart';
import 'explore.dart';

class CategoryScreen extends StatefulWidget {
  final List<Category> selectedCategories;
  final SelectCategory selectCategory;

  const CategoryScreen({
    Key? key,
    required this.selectedCategories,
    required this.selectCategory,
  }) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  var isInit = false;
  Future<List<Category>>? categoires;

  @override
  void didChangeDependencies() {
    if (isInit == false) {
      List<int> requiredCategories =
          CategoriesGrid.requiresChildernOf(context, widget.selectedCategories);

      if (requiredCategories.isNotEmpty) {
        categoires = Category.fetchCategoriesFor(
            widget.selectedCategories, requiredCategories);
      }

      isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (categoires != null) {
      return FutureBuilder<List<Category>>(
        future: categoires!,
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            return Text("error encountered when retrieving data");
          } else if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return CategoriesGrid(
              categories: snapshot.data!,
              selectCategory: widget.selectCategory,
            );
          }
        },
      );
    } else {
      return Container();
    }

    /*return FutureBuilder(
      future: attractions,
      builder: (ctx, snapshot) {
        if (snapshot.hasError) {
          return Text("error encountered when retrieving data");
        } else if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          final List<Attraction> attractions =
              snapshot.data as List<Attraction>;

          return Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${attractions.length} Results",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      child: CategoriesGrid(
                        categories: widget.categories,
                        selectCategory: widget.selectCategory,
                      ),
                    ),
                    Container(
                      height: 300,
                      child: ListView.builder(
                        itemBuilder: (_, index) => AttractionCard(
                          attraction: attractions[index],
                        ),
                        itemCount: attractions.length,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]);
        }
      },
    );*/
  }
}
