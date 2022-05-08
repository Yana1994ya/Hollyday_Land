import "package:flutter/material.dart";
import "package:hollyday_land/models/tour/filter.dart";
import "package:hollyday_land/models/tour/short.dart";
import "package:hollyday_land/screens/attractions.dart";
import 'package:hollyday_land/screens/tour/filter.dart';
import "package:hollyday_land/widgets/list_item.dart";
import "package:hollyday_land/widgets/tour/tour_list_item.dart";

class ToursScreen extends StatefulWidget {
  static const routePath = "/tours";

  const ToursScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TourScreenState();
}

class _TourScreenState
    extends AttractionsScreenState<ToursScreen, TourShort, TourFilter> {
  @override
  MaterialPageRoute filterPage(TourFilter filter) {
    return MaterialPageRoute(
        builder: (_) => TourFilterScreen(currentFilter: filter));
  }

  @override
  AttractionListItem<TourShort> getListItem(TourShort attraction) {
    return TourListItem(attraction: attraction);
  }

  @override
  TourFilter initFilter() {
    return TourFilter.create();
  }

  @override
  String itemCountText(List<TourShort> attractions) {
    return "found ${attractions.length} tours";
  }

  @override
  String get pageTitle => "Tours";

  @override
  Future<List<TourShort>> readAttractions(
      Map<String, Iterable<String>> params) {
    return tourShortObjects.readAttractions(params);
  }
}
