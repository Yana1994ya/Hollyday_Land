import "package:flutter/cupertino.dart";
import "package:hollyday_land/models/zoo/filter.dart";
import "package:hollyday_land/models/zoo/filter_options.dart";
import "package:hollyday_land/providers/zoo/filter.dart";
import "package:hollyday_land/screens/filter.dart";
import "package:hollyday_land/widgets/filter_selection.dart";
import "package:hollyday_land/widgets/zoo/filter_selection.dart";

class ZoosFilterScreen extends AttractionFilterScreen<ZooFilterOptions,
    ZooFilter, ZooFilterProvider> {
  const ZoosFilterScreen({Key? key, required ZooFilter currentFilter})
      : super(key: key, currentFilter: currentFilter);

  @override
  ZooFilterProvider createProvider() {
    return ZooFilterProvider.fromFilter(currentFilter);
  }

  @override
  Future<ZooFilterOptions> fetchOptions() {
    return ZooFilterOptions.fetch();
  }

  @override
  String get pageTitle => "Zoos";

  @override
  AttractionFilterSelectionWidget<ZooFilterOptions, ZooFilter,
      ZooFilterProvider> selectionWidget(ZooFilterOptions options) {
    return ZooFilterSelectionWidget(options: options);
  }
}
