import "package:flutter/material.dart";
import "package:hollyday_land/models/map_objects.dart";
import "package:hollyday_land/models/trail/filter.dart";
import "package:hollyday_land/models/trail/short.dart";
import "package:hollyday_land/providers/cache_key.dart";
import "package:hollyday_land/screens/attractions.dart";
import "package:hollyday_land/screens/map.dart";
import "package:hollyday_land/screens/trail/filter.dart";
import "package:hollyday_land/screens/trail/record.dart";
import "package:hollyday_land/widgets/list_item.dart";
import "package:hollyday_land/widgets/trail/trail_list_item.dart";
import "package:provider/provider.dart";

class TrailsScreen extends StatefulWidget {
  static const routePath = "/trails";

  @override
  State<StatefulWidget> createState() {
    return _TrailsScreenState();
  }
}

class _TrailsScreenState
    extends AttractionsScreenState<TrailsScreen, TrailShort, TrailsFilter> {
  @override
  AttractionListItem<TrailShort> getListItem(TrailShort attraction) {
    return TrailListItem(attraction: attraction);
  }

  @override
  String itemCountText(List<TrailShort> trips) {
    return "found ${trips.length} trails";
  }

  @override
  String get pageTitle => "Trails";

  @override
  TrailsFilter initFilter() => TrailsFilter.empty();

  @override
  Future<List<TrailShort>> readAttractions(
      Map<String, Iterable<String>> params) {
    return trailShortObjects.readAttractions(params);
  }

  @override
  List<Widget> actions(BuildContext context, TrailsFilter filter) {
    return [
      PopupMenuButton(
        onSelected: (index) {
          if (index == 1) {
            Navigator.of(context)
                .pushNamed(TrailRecordScreen.routePath)
                .then((value) {
              // If upload was successful, true is returned via pop
              if (value == true) {
                // Trigger refresh
                Provider.of<CacheKey>(context, listen: false).refresh();
              }
            });
          } else if (index == 2) {
            Navigator.of(context)
                .push(filterPage(filter))
                .then(filterSelectionResult);
          } else if (index == 3) {
            Navigator.of(context)
                .pushNamed(MapScreen.routePath, arguments: MapObjects.trails);
          }
        },
        itemBuilder: (context) => <PopupMenuEntry<int>>[
          PopupMenuItem<int>(
            value: 1,
            child: Row(
              children: [
                Icon(
                  Icons.fiber_manual_record,
                  color: Colors.red,
                ),
                Text(" Record trail"),
              ],
            ),
          ),
          PopupMenuItem<int>(
            value: 2,
            child: Row(
              children: [
                Icon(
                  Icons.filter_list,
                  color: Colors.black,
                ),
                Text(" Filter"),
              ],
            ),
          ),
          PopupMenuItem<int>(
            value: 3,
            child: Row(
              children: [
                SizedBox(
                  child: Image.asset("assets/graphics/map.png"),
                  width: 24,
                  height: 24,
                ),
                Text(" Map"),
              ],
            ),
          ),
        ],
      )
    ];
  }

  @override
  MaterialPageRoute filterPage(TrailsFilter filter) => MaterialPageRoute(
        builder: (_) => TrailsFilterScreen(initialFilter: filter),
      );
}
