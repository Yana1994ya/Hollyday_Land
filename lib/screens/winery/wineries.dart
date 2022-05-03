import "package:flutter/material.dart";
import "package:hollyday_land/models/filter/region_filter.dart";
import "package:hollyday_land/models/winery/short.dart";
import "package:hollyday_land/screens/attractions.dart";
import "package:hollyday_land/screens/region_filter.dart";
import "package:hollyday_land/widgets/list_item.dart";
import "package:hollyday_land/widgets/winery/list_item.dart";

class WineriesScreen extends StatefulWidget {
  static const routePath = "/wineries";

  @override
  State<StatefulWidget> createState() => _WineriesScreenState();
}

class _WineriesScreenState
    extends AttractionsScreenState<WineriesScreen, WineryShort, RegionFilter> {
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
  RegionFilter initFilter() => RegionFilter.empty();

  @override
  Future<List<WineryShort>> readAttractions(
      Map<String, Iterable<String>> params) {
    return wineryShortObjects.readAttractions(params);
  }

  @override
  MaterialPageRoute filterPage(RegionFilter filter) => MaterialPageRoute(
        builder: (_) => RegionFilterScreen(
          currentFilter: filter,
          pageTitle: pageTitle,
        ),
      );
}
