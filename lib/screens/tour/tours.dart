import "package:built_collection/built_collection.dart";
import "package:flutter/material.dart";
import "package:hollyday_land/models/tour/short.dart";
import "package:hollyday_land/providers/cache_key.dart";
import "package:provider/provider.dart";

class ToursScreen extends StatelessWidget {
  final BuiltMap<String, Iterable<String>> parameters;

  const ToursScreen({Key? key, required this.parameters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int cacheKey = Provider.of<CacheKey>(context).cacheKey;
    final Map<String, Iterable<String>> params = parameters.toMap();

    params["cache_key"] = [cacheKey.toString()];

    return Scaffold(
      appBar: AppBar(
        title: Text("tours"),
      ),
      body: FutureBuilder<List<TourShort>>(
        future: tourShortObjects.readAttractions(params),
        builder: (_, AsyncSnapshot<List<TourShort>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            final List<TourShort> tours = snapshot.data!;

            return ListView.builder(
              itemCount: tours.length,
              itemBuilder: (_, index) {
                return ListTile(
                    title: Text(tours[index].name +
                        " - " +
                        tours[index].price.toString()));
              },
            );
          }
        },
      ),
    );
  }
}