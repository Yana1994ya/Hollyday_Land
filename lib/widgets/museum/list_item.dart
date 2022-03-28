import "package:flutter/material.dart";
import "package:hollyday_land/models/museum/short.dart";
import "package:hollyday_land/screens/museum/museum.dart";
import "package:hollyday_land/widgets/managed_list_item.dart";

class MuseumListItem extends ManagedAttractionListItem<MuseumShort> {
  const MuseumListItem({Key? key, required MuseumShort museum})
      : super(key: key, attraction: museum);

  @override
  List<Widget> extraInformation(BuildContext context) {
    return super.extraInformation(context) +
        [
          Align(
            child: Text(attraction.domain.name),
            alignment: Alignment.topLeft,
          )
        ];
  }

  @override
  MaterialPageRoute get pageRoute =>
      MaterialPageRoute(builder: (_) => MuseumScreen(attraction: attraction));
}
