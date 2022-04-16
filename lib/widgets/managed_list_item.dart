import "package:flutter/material.dart";
import "package:hollyday_land/models/dao/base_attraction_short.dart";
import "package:hollyday_land/widgets/list_item.dart";
import "package:hollyday_land/widgets/region_and_city.dart";

abstract class ManagedAttractionListItem<
        Attraction extends ManagedAttractionShort>
    extends AttractionListItem<Attraction> {
  const ManagedAttractionListItem({Key? key, required Attraction attraction})
      : super(key: key, attraction: attraction);



  @override
  List<Widget> extraInformation(BuildContext context) {
    return [
      RegionAndCity(
        region: attraction.region.name,
        city: attraction.city,
      )
    ];
  }
}
