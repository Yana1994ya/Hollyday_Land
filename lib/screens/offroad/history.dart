import "package:flutter/material.dart";
import "package:hollyday_land/models/offroad/short.dart";
import "package:hollyday_land/screens/user_attractions.dart";
import "package:hollyday_land/widgets/list_item.dart";
import "package:hollyday_land/widgets/offroad/list_item.dart";

class HistoryOffRoadTripsScreen
    extends UserAttractionsScreen<OffRoadTripShort> {
  static const routePath = "/history/off_road_trips";

  @override
  AttractionListItem<OffRoadTripShort> getListItem(
      OffRoadTripShort attraction) {
    return OffRoadTripListItem(trip: attraction);
  }

  @override
  String itemCountText(List<OffRoadTripShort> attractions) {
    return "found ${attractions.length} off road trips";
  }

  @override
  String get pageTitle => "Visited off road trips";

  @override
  Future<List<OffRoadTripShort>> readAttractions(
    String hdToken,
    BuildContext context,
  ) {
    return OffRoadTripShort.readHistory(hdToken);
  }
}
