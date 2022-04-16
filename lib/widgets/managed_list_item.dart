import "package:flutter/material.dart";
import "package:hollyday_land/models/dao/base_attraction_short.dart";
import "package:hollyday_land/widgets/list_item.dart";

abstract class ManagedAttractionListItem<
        Attraction extends ManagedAttractionShort>
    extends AttractionListItem<Attraction> {
  const ManagedAttractionListItem({Key? key, required Attraction attraction})
      : super(key: key, attraction: attraction);

  static List<Widget> _city(String? city) {
    if (city == null) {
      return [];
    } else {
      return [
        Icon(Icons.arrow_right_rounded, size: 16.0),
        Text(
          city,
        ),
      ];
    }
  }

  static Widget locationWidget(String region, String? city) {
    return Row(
      children: [
        Text(
          region,
        ),
        ..._city(city)
      ],
    );
  }

  @override
  List<Widget> extraInformation(BuildContext context) {
    return [locationWidget(attraction.region.name, attraction.city)];
  }
}
