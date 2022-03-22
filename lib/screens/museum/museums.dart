import "package:flutter/material.dart";
import "package:hollyday_land/models/museum/filter.dart";
import "package:hollyday_land/models/museum/short.dart";
import "package:hollyday_land/screens/attractions.dart";
import "package:hollyday_land/screens/museum/filter.dart";
import "package:hollyday_land/widgets/list_item.dart";
import "package:hollyday_land/widgets/museum/list_item.dart";

class MuseumsScreen extends StatefulWidget {
  static const routePath = "/museums";

  @override
  State<StatefulWidget> createState() => _MuseumsScreenState();
}

class _MuseumsScreenState
    extends AttractionsScreenState<MuseumsScreen, MuseumShort, MuseumFilter> {
  @override
  AttractionListItem<MuseumShort> getListItem(MuseumShort museum) {
    return MuseumListItem(museum: museum);
  }

  @override
  String itemCountText(List<MuseumShort> museums) {
    return "found ${museums.length} museums";
  }

  @override
  String get pageTitle => "Museums";

  @override
  MuseumFilter initFilter() => MuseumFilter.empty();

  @override
  Future<List<MuseumShort>> readAttractions(
    Map<String, Iterable<String>> params,
  ) {
    return museumShortObjects.readAttractions(params);
  }

  @override
  MaterialPageRoute filterPage(MuseumFilter filter) => MaterialPageRoute(
        builder: (_) => MuseumsFilterScreen(currentFilter: filter),
      );
}
