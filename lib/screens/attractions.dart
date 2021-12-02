import "package:flutter/material.dart";
import "package:hollyday_land/models/attraction_short.dart";
import "package:hollyday_land/models/filter/attraction_filter.dart";
import "package:hollyday_land/providers/location_provider.dart";
import "package:hollyday_land/widgets/list_item.dart";
import "package:provider/provider.dart";

abstract class AttractionsScreenState<Parent extends StatefulWidget,
    AttractionType extends AttractionShort> extends State<Parent> {
  late AttractionFilter filter = initFilter();

  AttractionFilter initFilter();

  void filterSelectionResult(dynamic value) {
    if (value != null) {
      setState(() {
        filter = value as AttractionFilter;
      });
    }
  }

  String itemCountText(List<AttractionType> attractions);

  Future<List<AttractionType>> readAttractions(
      Map<String, Iterable<String>> params);

  Widget itemCount(BuildContext context, List<AttractionType> attractions) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 8,
      ),
      child: Text(itemCountText(attractions)),
    );
  }

  AttractionListItem<AttractionType> getListItem(AttractionType attraction);

  String get pageTitle;

  @override
  Widget build(BuildContext context) {
    // Attempt to retirve location at the load of this page
    Provider.of<LocationProvider>(context).retrieveLocation();

    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(filter.filterPage)
                    .then(filterSelectionResult);
              },
              icon: Icon(Icons.tune)),
        ],
      ),
      body: FutureBuilder(
        future: readAttractions(filter.parameters),
        builder: (_, AsyncSnapshot<List<AttractionType>> snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text(
              snapshot.error.toString(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ));
          } else if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<AttractionType> attractions = snapshot.data!;

            return ListView.builder(
              itemBuilder: (_, index) => index == 0
                  ? itemCount(context, attractions)
                  : getListItem(attractions[index - 1]),
              itemCount: attractions.length + 1,
            );
          }
        },
      ),
    );
  }
}
