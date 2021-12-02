import "package:flutter/material.dart";
import "package:hollyday_land/models/region_filter.dart";
import "package:hollyday_land/models/region_filter_options.dart";
import "package:hollyday_land/providers/region_filter.dart";
import "package:hollyday_land/widgets/filter_selection.dart";

class RegionFilterSelectionWidget extends AttractionFilterSelectionWidget<
    RegionFilterOptions, RegionFilter, RegionFilterProvider> {
  const RegionFilterSelectionWidget({
    Key? key,
    required RegionFilterOptions options,
  }) : super(
          key: key,
          options: options,
        );

  @override
  List<Widget> extraFilters(
    BuildContext context,
    RegionFilterProvider filterProvider,
    ColorScheme colorScheme,
  ) {
    return [];
  }
}
