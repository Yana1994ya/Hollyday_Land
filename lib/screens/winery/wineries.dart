import "package:flutter/material.dart";
import 'package:hollyday_land/models/winery/filter.dart';
import 'package:hollyday_land/models/winery/short.dart';
import 'package:hollyday_land/screens/winery/filter.dart';
import 'package:hollyday_land/widgets/list_item.dart';
import 'package:hollyday_land/widgets/winery/list_item.dart';

import '../attractions.dart';

class WineriesScreen extends StatefulWidget {
  static const routePath = "/wineries";

  @override
  State<StatefulWidget> createState() => _WineriesScreenState();
}

class _WineriesScreenState
    extends AttractionsScreenState<WineriesScreen, WineryShort, WineryFilter> {
  @override
  WineryFilter emptryFilter() {
    return WineryFilter.empty();
  }

  @override
  MaterialPageRoute get filterScreen => MaterialPageRoute(
        builder: (_) => WineriesFilterScreen(currentFilter: filter),
      );

  @override
  AttractionListItem<WineryShort> getListItem(WineryShort winery) {
    return WineryListItem(winery: winery);
  }

  @override
  String itemCountText(List<WineryShort> wineries) {
    return "found ${wineries.length} wineries";
  }

  @override
  Future<List<WineryShort>> readAttractions() {
    return WineryShort.readWineries(filter);
  }

  @override
  String get pageTitle => "Wineries";
}
