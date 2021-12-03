import "package:flutter/material.dart";
import "package:hollyday_land/models/filter/attraction_filter.dart";
import "package:hollyday_land/models/filter/region_filter.dart";
import "package:hollyday_land/models/zoo/short.dart";
import "package:hollyday_land/screens/attractions.dart";
import "package:hollyday_land/widgets/list_item.dart";
import "package:hollyday_land/widgets/zoo/list_item.dart";

class ZoosScreen extends StatefulWidget {
  static const routePath = "/zoos";

  @override
  State<StatefulWidget> createState() => _WineriesScreenState();
}

class _WineriesScreenState
    extends AttractionsScreenState<ZoosScreen, ZooShort> {
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
  AttractionFilter initFilter() {
    return RegionFilter(pageTitle, {});
  }

  @override
  Future<List<ZooShort>> readAttractions(Map<String, Iterable<String>> params) {
    throw ZooShort.readZoos(params);
  }
}
