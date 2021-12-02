import "package:flutter/material.dart";
import "package:hollyday_land/models/museum/filter_options.dart";
import "package:hollyday_land/models/museum/museum_domain.dart";
import "package:hollyday_land/providers/museum/filter.dart";
import "package:hollyday_land/widgets/filter/chips.dart";
import "package:hollyday_land/widgets/filter/region_chips.dart";
import "package:provider/provider.dart";

class MuseumFilterSelectionWidget extends StatelessWidget {
  final MuseumFilterOptions options;

  const MuseumFilterSelectionWidget({Key? key, required this.options})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<MuseumFilterProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: RegionChips.regionChips(
              context,
              colorScheme,
              options.regions,
              filterProvider,
            ) +
            [
              Divider(),
              Text(
                "Domain:",
                style: Theme.of(context).textTheme.headline6,
              ),
              Container(
                height: 5,
              ),
              FilterChips.choiceChips<MuseumDomain>(
                  items: options.domains,
                  isSelected: filterProvider.domainIsSelected,
                  toggle: filterProvider.toggleDomain,
                  title: (domain) => domain.name,
                  colorScheme: colorScheme)
            ],
      ),
    );
  }
}
