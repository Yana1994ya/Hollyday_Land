import "package:flutter/material.dart";
import "package:hollyday_land/models/extreme_sports/filter.dart";
import "package:hollyday_land/models/extreme_sports/short.dart";
import "package:hollyday_land/screens/attractions.dart";
import "package:hollyday_land/screens/extreme_sports/filter.dart";
import "package:hollyday_land/widgets/extreme_sports/list_item.dart";
import "package:hollyday_land/widgets/list_item.dart";

class ExtremeSportsListScreen extends StatefulWidget {
  static const routePath = "/extreme_sports_list";

  @override
  State<StatefulWidget> createState() => _ExtremeSportsListScreenState();
}

class _ExtremeSportsListScreenState extends AttractionsScreenState<
    ExtremeSportsListScreen, ExtremeSportsShort, ExtremeSportsFilter> {
  @override
  AttractionListItem<ExtremeSportsShort> getListItem(
      ExtremeSportsShort attraction) {
    return ExtremeSportsListItem(attraction: attraction);
  }

  @override
  String itemCountText(List<ExtremeSportsShort> attractions) {
    return "found ${attractions.length} extreme sports attractions";
  }

  @override
  String get pageTitle => "Extreme sports";

  @override
  ExtremeSportsFilter initFilter() => ExtremeSportsFilter.empty();

  @override
  Future<List<ExtremeSportsShort>> readAttractions(
      Map<String, Iterable<String>> params) {
    return extremeSportsShortObjects.readAttractions(params);
  }

  @override
  MaterialPageRoute filterPage(ExtremeSportsFilter filter) => MaterialPageRoute(
        builder: (_) => ExtremeSportsFilterScreen(currentFilter: filter),
      );
}
