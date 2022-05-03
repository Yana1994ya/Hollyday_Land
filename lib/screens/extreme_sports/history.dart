import "package:flutter/material.dart";
import "package:hollyday_land/models/extreme_sports/short.dart";
import "package:hollyday_land/screens/user_attractions.dart";
import "package:hollyday_land/widgets/extreme_sports/list_item.dart";
import "package:hollyday_land/widgets/list_item.dart";

class HistoryExtremeSportsScreen
    extends UserAttractionsScreen<ExtremeSportsShort> {
  static const routePath = "/history/extreme_sports";

  @override
  AttractionListItem<ExtremeSportsShort> getListItem(
      ExtremeSportsShort attraction) {
    return ExtremeSportsListItem(attraction: attraction);
  }

  @override
  String itemCountText(List<ExtremeSportsShort> attractions) {
    return "Visited ${attractions.length} extreme sports attractions";
  }

  @override
  String get pageTitle => "Visited extreme sports attractions";

  @override
  Future<List<ExtremeSportsShort>> readAttractions(
    String hdToken,
    BuildContext context,
  ) {
    return extremeSportsShortObjects.readHistory(hdToken);
  }
}
