import "package:flutter/material.dart";
import "package:hollyday_land/models/museum/filter.dart";
import "package:hollyday_land/models/museum/filter_options.dart";
import "package:hollyday_land/providers/museum/filter.dart";
import "package:hollyday_land/screens/filter.dart";
import "package:hollyday_land/widgets/filter_selection.dart";
import "package:hollyday_land/widgets/museum/filter_selection.dart";

class MuseumsFilterScreen extends AttractionFilterScreen<MuseumFilterOptions,
    MuseumFilter, MuseumFilterProvider> {
  const MuseumsFilterScreen({Key? key, required MuseumFilter currentFilter})
      : super(key: key, currentFilter: currentFilter);

  @override
  MuseumFilterProvider createProvider() {
    return MuseumFilterProvider.fromFilter(currentFilter);
  }

  @override
  Future<MuseumFilterOptions> fetchOptions() {
    return MuseumFilterOptions.fetch();
  }

  @override
  String get pageTitle => "Museums";

  @override
  AttractionFilterSelectionWidget<MuseumFilterOptions, MuseumFilter,
      MuseumFilterProvider> selectionWidget(MuseumFilterOptions options) {
    return MuseumFilterSelectionWidget(options: options);
  }
}
