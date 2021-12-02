import "package:hollyday_land/models/region_filter.dart";
import "package:hollyday_land/screens/region_filter.dart";

class ZoosFilterScreen extends RegionFilterScreen {
  const ZoosFilterScreen({required RegionFilter currentFilter})
      : super(currentFilter: currentFilter);

  @override
  String get pageTitle => "Zoos";
}
