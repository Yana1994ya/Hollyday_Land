import "package:flutter/material.dart";
import "package:hollyday_land/models/water_sports/filter.dart";
import "package:hollyday_land/models/water_sports/short.dart";
import "package:hollyday_land/screens/attractions.dart";
import "package:hollyday_land/screens/water_sports/filter.dart";
import "package:hollyday_land/widgets/list_item.dart";
import "package:hollyday_land/widgets/water_sports/list_item.dart";

class WaterSportsListScreen extends StatefulWidget {
  static const routePath = "/water_sports_list";

  @override
  State<StatefulWidget> createState() => _WaterSportsListScreenState();
}

class _WaterSportsListScreenState extends AttractionsScreenState<
    WaterSportsListScreen, WaterSportsShort, WaterSportsFilter> {
  @override
  AttractionListItem<WaterSportsShort> getListItem(
      WaterSportsShort attraction) {
    return WaterSportsListItem(attraction: attraction);
  }

  @override
  String itemCountText(List<WaterSportsShort> attractions) {
    return "found ${attractions.length} water sports attractions";
  }

  @override
  String get pageTitle => "Water sports";

  @override
  WaterSportsFilter initFilter() => WaterSportsFilter.empty();

  @override
  Future<List<WaterSportsShort>> readAttractions(
      Map<String, Iterable<String>> params) {
    return waterSportsShortObjects.readAttractions(params);
  }

  @override
  MaterialPageRoute filterPage(WaterSportsFilter filter) => MaterialPageRoute(
        builder: (_) => WaterSportsFilterScreen(currentFilter: filter),
      );
}
