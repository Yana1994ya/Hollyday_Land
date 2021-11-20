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
  MuseumFilter emptryFilter() {
    return MuseumFilter.empty();
  }

  @override
  MaterialPageRoute get filterScreen => MaterialPageRoute(
        builder: (_) => MuseumsFilterScreen(currentFilter: filter),
      );

  @override
  AttractionListItem<MuseumShort> getListItem(MuseumShort museum) {
    return MuseumListItem(museum: museum);
  }

  @override
  String itemCountText(List<MuseumShort> museums) {
    return "found ${museums.length} museums";
  }

  @override
  Future<List<MuseumShort>> readAttractions() {
    return MuseumShort.readMuseums(filter);
  }

  @override
  String get pageTitle => "Museums";
}
