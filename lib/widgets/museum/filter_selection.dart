import "package:flutter/material.dart";
import "package:hollyday_land/models/museum/filter.dart";
import "package:hollyday_land/models/museum/filter_options.dart";
import "package:hollyday_land/models/museum/museum_domain.dart";
import "package:hollyday_land/providers/museum/filter.dart";
import "package:hollyday_land/widgets/filter_selection.dart";

class MuseumFilterSelectionWidget extends AttractionFilterSelectionWidget<
    MuseumFilterOptions, MuseumFilter, MuseumFilterProvider> {
  const MuseumFilterSelectionWidget(
      {Key? key, required MuseumFilterOptions options})
      : super(key: key, options: options);

  @override
  List<Widget> extraFilters(BuildContext context,
      MuseumFilterProvider filterProvider, ColorScheme colorScheme) {
    return [
      Divider(),
      Text(
        "Domain:",
        style: Theme.of(context).textTheme.headline6,
      ),
      Container(
        height: 5,
      ),
      Wrap(
        children: choiceChips<MuseumDomain>(
            items: options.domains,
            isSelected: filterProvider.domainSelected,
            toggle: filterProvider.toggleDomain,
            title: (domain) => domain.name,
            colorScheme: colorScheme),
        spacing: 8.0,
      )
    ];
  }
}
