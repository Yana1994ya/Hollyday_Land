import "package:flutter/material.dart";
import "package:hollyday_land/models/region.dart";
import "package:hollyday_land/providers/region_filter.dart";
import "package:hollyday_land/widgets/filter/region_chips.dart";
import "package:provider/provider.dart";

class RegionFilterSelectionWidget extends StatelessWidget {
  final List<Region> regionOptions;

  const RegionFilterSelectionWidget({
    Key? key,
    required this.regionOptions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<RegionFilterProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        children: RegionChips.regionChips(
          context,
          colorScheme,
          regionOptions,
          filterProvider,
        ),
      ),
    );
  }
}
