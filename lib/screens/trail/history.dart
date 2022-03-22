import "package:flutter/material.dart";
import "package:hollyday_land/models/trail/short.dart";
import "package:hollyday_land/screens/user_attractions.dart";
import "package:hollyday_land/widgets/list_item.dart";
import "package:hollyday_land/widgets/trail/trail_list_item.dart";

class HistoryTrailsScreen extends UserAttractionsScreen<TrailShort> {
  static const routePath = "/history/trails";

  @override
  AttractionListItem<TrailShort> getListItem(TrailShort attraction) {
    return TrailListItem(attraction: attraction);
  }

  @override
  String itemCountText(List<TrailShort> attractions) {
    return "found ${attractions.length} trails";
  }

  @override
  String get pageTitle => "Visited trails";

  @override
  Future<List<TrailShort>> readAttractions(
    String hdToken,
    BuildContext context,
  ) {
    return trailShortObjects.readHistory(hdToken);
  }
}
