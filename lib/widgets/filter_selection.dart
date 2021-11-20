import "package:flutter/material.dart";
import "package:hollyday_land/models/attraction_filter.dart";
import "package:hollyday_land/models/attraction_filter_options.dart";
import "package:hollyday_land/models/region.dart";
import "package:hollyday_land/providers/attraction_filter.dart";
import "package:provider/provider.dart";

abstract class AttractionFilterSelectionWidget<
        Options extends AttractionFilterOptions,
        FilterType extends AttractionFilter,
        ProviderType extends AttractionFilterProvider<AttractionFilter>>
    extends StatelessWidget {
  final Options options;

  const AttractionFilterSelectionWidget({Key? key, required this.options})
      : super(key: key);

  List<Widget> choiceChips<T>({
    required List<T> items,
    required bool Function(T) isSelected,
    required void Function(T) toggle,
    required String Function(T) title,
    required ColorScheme colorScheme,
  }) {
    return items.map((item) {
      final selected = isSelected(item);

      return ChoiceChip(
        backgroundColor: Colors.transparent,
        shape: StadiumBorder(
            side: BorderSide(
          color: colorScheme.primary,
        )),
        selectedColor: colorScheme.primary,
        label: Text(
          title(item),
          style: TextStyle(
            color: selected ? Colors.white : colorScheme.primary,
          ),
        ),
        selected: selected,
        onSelected: (_) {
          toggle(item);
        },
      );
    }).toList();
  }

  List<Widget> extraFilters(BuildContext context, ProviderType filterProvider,
      ColorScheme colorScheme);

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<ProviderType>(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: [
          Text(
            "Region:",
            style: Theme.of(context).textTheme.headline6,
          ),
          Container(
            height: 5,
          ),
          Wrap(
            children: choiceChips<Region>(
                items: options.regions,
                isSelected: filterProvider.regionSelected,
                toggle: filterProvider.toggleRegion,
                title: (region) => region.name,
                colorScheme: colorScheme),
            spacing: 8.0,
          ),
          ...extraFilters(context, filterProvider, colorScheme),
        ],
      ),
    );
  }
}
