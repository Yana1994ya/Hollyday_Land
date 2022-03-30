import "package:flutter/material.dart";
import "package:hollyday_land/models/extreme_sports/short.dart";
import "package:hollyday_land/screens/extreme_sports/item.dart";
import "package:hollyday_land/widgets/managed_list_item.dart";

class ExtremeSportsListItem
    extends ManagedAttractionListItem<ExtremeSportsShort> {
  const ExtremeSportsListItem(
      {Key? key, required ExtremeSportsShort attraction})
      : super(key: key, attraction: attraction);

  @override
  List<Widget> extraInformation(BuildContext context) {
    return super.extraInformation(context) +
        [
          Align(
            child: Text(attraction.sportsType.name),
            alignment: Alignment.topLeft,
          )
        ];
  }

  @override
  MaterialPageRoute get pageRoute => MaterialPageRoute(
      builder: (_) => ExtremeSportsItemScreen(attraction: attraction));
}
