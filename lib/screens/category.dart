import 'package:flutter/material.dart';
import 'package:hollyday_land/widgets/attraction.dart';

import '../models/attraction.dart';
import '../models/category.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;
  final VoidCallback unselectCategory;

  const CategoryScreen(
      {Key? key, required this.category, required this.unselectCategory})
      : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late Future<List<Attraction>> attractions;

  @override
  void initState() {
    super.initState();

    attractions = Attraction.fetchAttractions(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: attractions,
      builder: (ctx, snapshot) {
        if (snapshot.hasError) {
          return Text("error encountered when retrieving data");
        } else if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          final List<Attraction> attractions =
              snapshot.data as List<Attraction>;

          return ListView(padding: const EdgeInsets.all(8), children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${attractions.length} Results",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            ...attractions
                .map((attr) => AttractionCard(attraction: attr))
                .toList(),
          ]);
        }
      },
    );
  }
}
