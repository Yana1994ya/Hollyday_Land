import "package:flutter/material.dart";
import 'package:hollyday_land/models/hot_air/short.dart';
import "package:hollyday_land/screens/user_attractions.dart";
import 'package:hollyday_land/widgets/hot_air/list_item.dart';
import "package:hollyday_land/widgets/list_item.dart";

class HistoryHotAirScreen extends UserAttractionsScreen<HotAirShort> {
  static const routePath = "/history/hot_air";

  @override
  AttractionListItem<HotAirShort> getListItem(HotAirShort attraction) {
    return HotAirListItem(
      attraction: attraction,
    );
  }

  @override
  String itemCountText(List<HotAirShort> attractions) {
    return "visited ${attractions.length} hot air attractions";
  }

  @override
  String get pageTitle => "Visited hot air balloon attraction";

  @override
  Future<List<HotAirShort>> readAttractions(
    String hdToken,
    BuildContext context,
  ) {
    return hotAirShortObjects.readHistory(hdToken);
  }
}
