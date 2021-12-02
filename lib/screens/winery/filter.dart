import "package:hollyday_land/models/region_filter.dart";
import "package:hollyday_land/screens/region_filter.dart";

class WineriesFilterScreen extends RegionFilterScreen {
  const WineriesFilterScreen({required RegionFilter currentFilter})
      : super(currentFilter: currentFilter);

  @override
  String get pageTitle => "Wineries";
}
