import "package:flutter/material.dart";
import 'package:hollyday_land/models/region_filter.dart';
import "package:hollyday_land/models/zoo/short.dart";
import "package:hollyday_land/screens/attractions.dart";
import "package:hollyday_land/screens/zoo/filter.dart";
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
  RegionFilter emptryFilter() {
    return RegionFilter.empty();
  }

  @override
  MaterialPageRoute get filterScreen => MaterialPageRoute(
        builder: (_) => ZoosFilterScreen(currentFilter: filter),
      );

  @override
  AttractionListItem<ZooShort> getListItem(ZooShort zoo) {
    return ZooListItem(zoo: zoo);
  }

  @override
  String itemCountText(List<ZooShort> wineries) {
    return "found ${wineries.length} zoos";
  }

  @override
  Future<List<ZooShort>> readAttractions() {
    return ZooShort.readZoos(filter);
  }

  @override
  String get pageTitle => "Zoos";
}
