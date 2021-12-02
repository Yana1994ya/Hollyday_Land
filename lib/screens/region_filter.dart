import "package:flutter/cupertino.dart";
import "package:hollyday_land/models/region_filter.dart";
import "package:hollyday_land/models/region_filter_options.dart";
import "package:hollyday_land/providers/region_filter.dart";
import "package:hollyday_land/screens/filter.dart";
import "package:hollyday_land/widgets/filter_selection.dart";
import "package:hollyday_land/widgets/region_filter_selection.dart";

abstract class RegionFilterScreen extends AttractionFilterScreen<
    RegionFilterOptions, RegionFilter, RegionFilterProvider> {
  const RegionFilterScreen({Key? key, required RegionFilter currentFilter})
      : super(key: key, currentFilter: currentFilter);

  @override
  RegionFilterProvider createProvider() {
    return RegionFilterProvider.fromFilter(currentFilter);
  }

  @override
  Future<RegionFilterOptions> fetchOptions() {
    return RegionFilterOptions.fetch();
  }

  @override
  AttractionFilterSelectionWidget<RegionFilterOptions, RegionFilter,
      RegionFilterProvider> selectionWidget(RegionFilterOptions options) {
    return RegionFilterSelectionWidget(options: options);
  }
}
