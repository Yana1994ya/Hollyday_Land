import "package:flutter/material.dart";
import "package:hollyday_land/models/zoo/filter.dart";
import "package:hollyday_land/models/zoo/filter_options.dart";
import "package:hollyday_land/providers/zoo/filter.dart";
import "package:hollyday_land/widgets/filter_selection.dart";

class ZooFilterSelectionWidget extends AttractionFilterSelectionWidget<
    ZooFilterOptions, ZooFilter, ZooFilterProvider> {
  const ZooFilterSelectionWidget({
    Key? key,
    required ZooFilterOptions options,
  }) : super(
          key: key,
          options: options,
        );

  @override
  List<Widget> extraFilters(
    BuildContext context,
    ZooFilterProvider filterProvider,
    ColorScheme colorScheme,
  ) {
    return [];
  }
}
