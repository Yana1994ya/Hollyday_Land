import "package:flutter/material.dart";
import 'package:hollyday_land/models/tour/short.dart';
import "package:hollyday_land/screens/user_attractions.dart";
import "package:hollyday_land/widgets/list_item.dart";
import 'package:hollyday_land/widgets/tour/tour_list_item.dart';

class HistoryToursScreen extends UserAttractionsScreen<TourShort> {
  static const routePath = "/history/tours";

  @override
  AttractionListItem<TourShort> getListItem(TourShort attraction) {
    return TourListItem(attraction: attraction);
  }

  @override
  String itemCountText(List<TourShort> attractions) {
    return "found ${attractions.length} tours";
  }

  @override
  String get pageTitle => "Visited tours";

  @override
  Future<List<TourShort>> readAttractions(
    String hdToken,
    BuildContext context,
  ) {
    return tourShortObjects.readHistory(hdToken);
  }
}
