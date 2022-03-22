import "package:flutter/material.dart";
import "package:hollyday_land/models/rock_climbing/short.dart";
import "package:hollyday_land/screens/user_attractions.dart";
import "package:hollyday_land/widgets/list_item.dart";
import "package:hollyday_land/widgets/rock_climbing/list_item.dart";

class HistoryRockClimbingScreen
    extends UserAttractionsScreen<RockClimbingShort> {
  static const routePath = "/history/rock_climbing";

  @override
  AttractionListItem<RockClimbingShort> getListItem(
      RockClimbingShort attraction) {
    return RockClimbingListItem(attraction: attraction);
  }

  @override
  String itemCountText(List<RockClimbingShort> attractions) {
    return "Visited ${attractions.length} rock climbing attractions";
  }

  @override
  String get pageTitle => "Visited rock climbing attractions";

  @override
  Future<List<RockClimbingShort>> readAttractions(
    String hdToken,
    BuildContext context,
  ) {
    return rockClimbingShortObjects.readHistory(hdToken);
  }
}
