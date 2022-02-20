import "package:flutter/material.dart";
import "package:hollyday_land/models/filter/region_filter.dart";
import "package:hollyday_land/models/zoo/short.dart";
import "package:hollyday_land/screens/attractions.dart";
import "package:hollyday_land/screens/region_filter.dart";
import "package:hollyday_land/widgets/list_item.dart";
import "package:hollyday_land/widgets/zoo/list_item.dart";

class ZoosScreen extends StatefulWidget {
  static const routePath = "/zoos";

  @override
  State<StatefulWidget> createState() => _WineriesScreenState();
}

class _WineriesScreenState
    extends AttractionsScreenState<ZoosScreen, ZooShort, RegionFilter> {
  @override
  AttractionListItem<ZooShort> getListItem(ZooShort zoo) {
    return ZooListItem(zoo: zoo);
  }

  @override
  String itemCountText(List<ZooShort> wineries) {
    return "found ${wineries.length} zoos";
  }

  @override
  String get pageTitle => "Zoos";

  @override
  RegionFilter initFilter() => RegionFilter.empty();

  @override
  Future<List<ZooShort>> readAttractions(Map<String, Iterable<String>> params) {
    return ZooShort.readZoos(params);
  }

  @override
  MaterialPageRoute filterPage(RegionFilter filter) => MaterialPageRoute(
        builder: (_) => RegionFilterScreen(
          currentFilter: filter,
          pageTitle: pageTitle,
        ),
      );
}
