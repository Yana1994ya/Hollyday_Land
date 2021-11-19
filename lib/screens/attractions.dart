import "package:flutter/material.dart";
import "package:hollyday_land/models/attraction_short.dart";
import "package:hollyday_land/widgets/list_item.dart";

abstract class AttractionsScreenState<Parent extends StatefulWidget,
    T extends AttractionShort, TFilter> extends State<Parent> {
  late TFilter filter = emptryFilter();

  TFilter emptryFilter();

  void filterSelectionResult(dynamic value) {
    if (value != null) {
      setState(() {
        filter = value as TFilter;
      });
    }
  }

  String itemCountText(List<T> attractions);

  MaterialPageRoute get filterScreen;

  Future<List<T>> readAttractions();

  Widget itemCount(BuildContext context, List<T> attractions) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 8,
      ),
      child: Text(itemCountText(attractions)),
    );
  }

  AttractionListItem<T> getListItem(T attraction);

  String get pageTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(filterScreen)
                    .then(filterSelectionResult);
              },
              icon: Icon(Icons.tune)),
        ],
      ),
      body: FutureBuilder(
        future: readAttractions(),
        builder: (_, AsyncSnapshot<List<T>> snapshot) {
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
            List<T> attractions = snapshot.data!;

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
