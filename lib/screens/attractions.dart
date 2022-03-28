import "package:flutter/material.dart";
import "package:hollyday_land/models/dao/base_attraction_short.dart";
import "package:hollyday_land/models/filter/attraction_filter.dart";
import "package:hollyday_land/providers/cache_key.dart";
import "package:hollyday_land/providers/location_provider.dart";
import "package:hollyday_land/widgets/list_item.dart";
import "package:provider/provider.dart";

abstract class AttractionsScreenState<
    WidgetType extends StatefulWidget,
    AttractionType extends AttractionShort,
    Filter extends AttractionFilter> extends State<WidgetType> {
  late Filter _filter = initFilter();

  Filter initFilter();

  void filterSelectionResult(dynamic value) {
    if (value != null) {
      setState(() {
        _filter = value as Filter;
      });
    }
  }

  MaterialPageRoute filterPage(Filter filter);

  String itemCountText(List<AttractionType> attractions);

  Future<List<AttractionType>> readAttractions(
    Map<String, Iterable<String>> params,
  );

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

  List<Widget> actions(BuildContext context, Filter filter) {
    return [
      IconButton(
          onPressed: () {
            Navigator.of(context)
                .push(filterPage(filter))
                .then(filterSelectionResult);
          },
          icon: Icon(Icons.tune)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // Attempt to retrieve location at the load of this page
    Provider.of<LocationProvider>(context, listen: false).retrieveLocation();
    final cacheKey = Provider.of<CacheKey>(context).cacheKey;

    final filterParams = _filter.parameters;
    filterParams["cache_key"] = [cacheKey.toString()];

    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
        actions: actions(context, _filter),
      ),
      body: FutureBuilder(
        future: readAttractions(filterParams),
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
