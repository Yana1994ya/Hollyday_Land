import "package:flutter/material.dart";
import "package:hollyday_land/models/filter/region_filter.dart";
import "package:hollyday_land/models/hot_air/short.dart";
import "package:hollyday_land/screens/attractions.dart";
import "package:hollyday_land/screens/region_filter.dart";
import "package:hollyday_land/widgets/hot_air/list_item.dart";
import "package:hollyday_land/widgets/list_item.dart";

class HotAirListScreen extends StatefulWidget {
  static const routePath = "/hot_air_list";

  @override
  State<StatefulWidget> createState() => _HotAirListScreenState();
}

class _HotAirListScreenState extends AttractionsScreenState<HotAirListScreen,
    HotAirShort, RegionFilter> {
  @override
  AttractionListItem<HotAirShort> getListItem(HotAirShort attraction) {
    return HotAirListItem(attraction: attraction);
  }

  @override
  String itemCountText(List<HotAirShort> attractions) {
    return "found ${attractions.length} hot air balloon attractions";
  }

  @override
  String get pageTitle => "Hot air balloon attractions";

  @override
  RegionFilter initFilter() => RegionFilter.empty();

  @override
  Future<List<HotAirShort>> readAttractions(
      Map<String, Iterable<String>> params) {
    return hotAirShortObjects.readAttractions(params);
  }

  @override
  MaterialPageRoute filterPage(RegionFilter filter) => MaterialPageRoute(
        builder: (_) => RegionFilterScreen(
          currentFilter: filter,
          pageTitle: pageTitle,
        ),
      );
}
