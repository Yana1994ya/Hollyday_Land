import "package:flutter/material.dart";
import "package:hollyday_land/models/water_sports/short.dart";
import "package:hollyday_land/screens/user_attractions.dart";
import "package:hollyday_land/widgets/list_item.dart";
import "package:hollyday_land/widgets/water_sports/list_item.dart";

class HistoryWaterSportsScreen extends UserAttractionsScreen<WaterSportsShort> {
  static const routePath = "/history/water_sports";

  @override
  AttractionListItem<WaterSportsShort> getListItem(
      WaterSportsShort attraction) {
    return WaterSportsListItem(attraction: attraction);
  }

  @override
  String itemCountText(List<WaterSportsShort> attractions) {
    return "Visited ${attractions.length} water sports attractions";
  }

  @override
  String get pageTitle => "Visited water sports attractions";

  @override
  Future<List<WaterSportsShort>> readAttractions(
    String hdToken,
    BuildContext context,
  ) {
    return waterSportsShortObjects.readHistory(hdToken);
  }
}
