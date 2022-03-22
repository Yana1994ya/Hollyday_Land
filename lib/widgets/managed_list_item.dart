import "package:flutter/material.dart";
import "package:hollyday_land/models/dao/base_attraction_short.dart";
import "package:hollyday_land/widgets/list_item.dart";

abstract class ManagedAttractionListItem<
        Attraction extends ManagedAttractionShort>
    extends AttractionListItem<Attraction> {
  const ManagedAttractionListItem({Key? key, required Attraction attraction})
      : super(key: key, attraction: attraction);

  List<Widget> get _city {
    if (attraction.city == null) {
      return [];
    } else {
      return [
        Icon(Icons.arrow_right_rounded, size: 16.0),
        Text(
          attraction.city!,
        ),
      ];
    }
  }

  @override
  List<Widget> extraInformation(BuildContext context) {
    return [
      Row(
        children: [
          Text(
            attraction.region.name,
          ),
          ..._city
        ],
      )
    ];
  }
}
