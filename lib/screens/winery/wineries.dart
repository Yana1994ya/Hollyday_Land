import "package:flutter/material.dart";
import "package:hollyday_land/models/filter/attraction_filter.dart";
import "package:hollyday_land/models/filter/region_filter.dart";
import "package:hollyday_land/models/winery/short.dart";
import "package:hollyday_land/screens/attractions.dart";
import "package:hollyday_land/widgets/list_item.dart";
import "package:hollyday_land/widgets/winery/list_item.dart";

class WineriesScreen extends StatefulWidget {
  static const routePath = "/wineries";

  @override
  State<StatefulWidget> createState() => _WineriesScreenState();
}

class _WineriesScreenState
    extends AttractionsScreenState<WineriesScreen, WineryShort> {
  @override
  String get pageTitle => "Wineries";

  @override
  AttractionListItem<WineryShort> getListItem(WineryShort winery) {
    return WineryListItem(winery: winery);
  }

  @override
  String itemCountText(List<WineryShort> wineries) {
    return "found ${wineries.length} wineries";
  }

  @override
  AttractionFilter initFilter() {
    return RegionFilter(pageTitle, {});
  }

  @override
  Future<List<WineryShort>> readAttractions(
      Map<String, Iterable<String>> params) {
    return WineryShort.readWineries(params);
  }
}
