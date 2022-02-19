import "package:flutter/material.dart";
import "package:hollyday_land/models/rock_climbing/short.dart";
import "package:hollyday_land/screens/rock_climbing/item.dart";
import "package:hollyday_land/widgets/list_item.dart";

class RockClimbingListItem extends AttractionListItem<RockClimbingShort> {
  const RockClimbingListItem({Key? key, required RockClimbingShort attraction})
      : super(key: key, attraction: attraction);

  @override
  List<Widget> extraInformation(BuildContext context) {
    return [
      Align(
        child: Text(attraction.attractionType.name),
        alignment: Alignment.topLeft,
      )
    ];
  }

  @override
  MaterialPageRoute get pageRoute => MaterialPageRoute(
      builder: (_) => RockClimbingItemScreen(attraction: attraction));
}
