import "package:flutter/cupertino.dart";
import "package:hollyday_land/models/winery/filter.dart";
import "package:hollyday_land/models/winery/filter_options.dart";
import "package:hollyday_land/providers/winery/filter.dart";
import "package:hollyday_land/screens/filter.dart";
import "package:hollyday_land/widgets/filter_selection.dart";
import "package:hollyday_land/widgets/winery/filter_selection.dart";

class WineriesFilterScreen extends AttractionFilterScreen<WineryFilterOptions,
    WineryFilter, WineryFilterProvider> {
  const WineriesFilterScreen({Key? key, required WineryFilter currentFilter})
      : super(key: key, currentFilter: currentFilter);

  @override
  WineryFilterProvider createProvider() {
    return WineryFilterProvider.fromFilter(currentFilter);
  }

  @override
  Future<WineryFilterOptions> fetchOptions() {
    return WineryFilterOptions.fetch();
  }

  @override
  String get pageTitle => "Wineries";

  @override
  AttractionFilterSelectionWidget<WineryFilterOptions, WineryFilter,
      WineryFilterProvider> selectionWidget(WineryFilterOptions options) {
    return WineryFilterSelectionWidget(options: options);
  }
}
