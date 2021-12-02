import "package:flutter/material.dart";
import "package:hollyday_land/models/region.dart";
import "package:hollyday_land/providers/region_ids.dart";
import "package:hollyday_land/widgets/filter/chips.dart";

class RegionChips {
  static List<Widget> regionChips(BuildContext context, ColorScheme colorScheme,
      List<Region> regions, RegionIds provider) {
    return [
      Text(
        "Region:",
        style: Theme.of(context).textTheme.headline6,
      ),
      Container(
        height: 5,
      ),
      FilterChips.choiceChips<Region>(
          items: regions,
          isSelected: provider.regionIsSelected,
          toggle: provider.regionToggle,
          title: (region) => region.name,
          colorScheme: colorScheme),
    ];
  }
}
