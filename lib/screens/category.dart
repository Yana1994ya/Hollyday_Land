import 'package:flutter/material.dart';

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

  Widget attractionCard(Attraction attraction) {
    final image = attraction.image == null
        ? Image.asset("assets/graphics/icon.png")
        : Image.network(attraction.image!);

    return Card(
      child: Container(
        padding: EdgeInsets.all(5),
        height: 100,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: image,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(attraction.name),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.favorite_border,
              color: Colors.pink,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
          ],
        ),
      ),
    );
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
            Row(
              children: [
                IconButton(
                    onPressed: widget.unselectCategory,
                    icon: const Icon(Icons.keyboard_return))
              ],
            ),
            ...attractions.map((attr) => attractionCard(attr)).toList(),
          ]);
        }
      },
    );
  }
}
