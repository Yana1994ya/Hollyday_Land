import "package:flutter/material.dart";
import "package:hollyday_land/models/winery/winery_filter.dart";
import "package:hollyday_land/models/winery/winery_filter_options.dart";
import "package:hollyday_land/providers/winery/filter.dart";
import "package:hollyday_land/widgets/filter_selection.dart";

class WineryFilterSelectionWidget extends AttractionFilterSelectionWidget<
    WineryFilterOptions, WineryFilter, WineryFilterProvider> {
  const WineryFilterSelectionWidget({
    Key? key,
    required WineryFilterOptions options,
  }) : super(
          key: key,
          options: options,
        );

  @override
  List<Widget> extraFilters(
    BuildContext context,
    WineryFilterProvider filterProvider,
    ColorScheme colorScheme,
  ) {
    return [];
  }
}
