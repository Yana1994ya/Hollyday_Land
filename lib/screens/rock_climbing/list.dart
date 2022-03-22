import "package:flutter/material.dart";
import "package:hollyday_land/models/rock_climbing/filter.dart";
import "package:hollyday_land/models/rock_climbing/short.dart";
import "package:hollyday_land/screens/attractions.dart";
import "package:hollyday_land/screens/rock_climbing/filter.dart";
import "package:hollyday_land/widgets/list_item.dart";
import "package:hollyday_land/widgets/rock_climbing/list_item.dart";

class RockClimbingListScreen extends StatefulWidget {
  static const routePath = "/rock_climbing_list";

  @override
  State<StatefulWidget> createState() => _RockClimbingListScreenState();
}

class _RockClimbingListScreenState extends AttractionsScreenState<
    RockClimbingListScreen, RockClimbingShort, RockClimbingFilter> {
  @override
  AttractionListItem<RockClimbingShort> getListItem(
      RockClimbingShort attraction) {
    return RockClimbingListItem(attraction: attraction);
  }

  @override
  String itemCountText(List<RockClimbingShort> trips) {
    return "found ${trips.length} rock climbing attractions";
  }

  @override
  String get pageTitle => "Rock climbing";

  @override
  RockClimbingFilter initFilter() => RockClimbingFilter.empty();

  @override
  Future<List<RockClimbingShort>> readAttractions(
      Map<String, Iterable<String>> params) {
    return rockClimbingShortObjects.readAttractions(params);
  }

  @override
  MaterialPageRoute filterPage(RockClimbingFilter filter) => MaterialPageRoute(
        builder: (_) => RockClimbingFilterScreen(currentFilter: filter),
      );
}
