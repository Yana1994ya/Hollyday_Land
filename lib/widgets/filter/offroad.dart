import "package:flutter/material.dart";
import "package:hollyday_land/models/offroad/filter_options.dart";
import "package:hollyday_land/models/offroad/trip_type.dart";
import "package:hollyday_land/providers/offroad/filter.dart";
import "package:hollyday_land/widgets/filter/chips.dart";
import "package:hollyday_land/widgets/filter/region_chips.dart";
import "package:provider/provider.dart";

class OffRoadTripFilterSelectionWidget extends StatelessWidget {
  final OffRoadTripFilterOptions options;

  const OffRoadTripFilterSelectionWidget({Key? key, required this.options})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<OffRoadTripFilterProvider>(context);
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
                "Trip Type:",
                style: Theme.of(context).textTheme.headline6,
              ),
              Container(
                height: 5,
              ),
              FilterChips.choiceChips<TripType>(
                items: options.tripTypes,
                isSelected: filterProvider.tripTypeIsSelected,
                toggle: filterProvider.toggleTripType,
                title: (domain) => domain.name,
                colorScheme: colorScheme,
              )
            ],
      ),
    );
  }
}
