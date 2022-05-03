import "package:flutter/material.dart";
import "package:hollyday_land/models/offroad/filter.dart";
import "package:hollyday_land/models/offroad/short.dart";
import "package:hollyday_land/screens/attractions.dart";
import "package:hollyday_land/screens/offroad/filter.dart";
import "package:hollyday_land/widgets/list_item.dart";
import "package:hollyday_land/widgets/offroad/list_item.dart";

class OffRoadTripsScreen extends StatefulWidget {
  static const routePath = "/offroad_trips";

  @override
  State<StatefulWidget> createState() => _OffRoadTripsScreenState();
}

class _OffRoadTripsScreenState extends AttractionsScreenState<
    OffRoadTripsScreen, OffRoadTripShort, OffRoadTripFilter> {
  @override
  AttractionListItem<OffRoadTripShort> getListItem(OffRoadTripShort trip) {
    return OffRoadTripListItem(trip: trip);
  }

  @override
  String itemCountText(List<OffRoadTripShort> trips) {
    return "found ${trips.length} off road trips";
  }

  @override
  String get pageTitle => "Off Road Trips";

  @override
  OffRoadTripFilter initFilter() => OffRoadTripFilter.empty();

  @override
  Future<List<OffRoadTripShort>> readAttractions(
      Map<String, Iterable<String>> params) {
    return offRoadTripShortObjects.readAttractions(params);
  }

  @override
  MaterialPageRoute filterPage(OffRoadTripFilter filter) => MaterialPageRoute(
        builder: (_) => OffRoadFilterScreen(currentFilter: filter),
      );
}
