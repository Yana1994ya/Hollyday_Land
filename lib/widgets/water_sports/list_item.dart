import "package:flutter/material.dart";
import "package:hollyday_land/models/water_sports/short.dart";
import "package:hollyday_land/screens/water_sports/item.dart";
import "package:hollyday_land/widgets/managed_list_item.dart";

class WaterSportsListItem extends ManagedAttractionListItem<WaterSportsShort> {
  const WaterSportsListItem({Key? key, required WaterSportsShort attraction})
      : super(key: key, attraction: attraction);

  @override
  List<Widget> extraInformation(BuildContext context) {
    return super.extraInformation(context) +
        [
          Align(
            child: Text(attraction.attractionType.name),
            alignment: Alignment.topLeft,
          )
        ];
  }

  @override
  MaterialPageRoute get pageRoute => MaterialPageRoute(
      builder: (_) => WaterSportsItemScreen(attraction: attraction));
}
