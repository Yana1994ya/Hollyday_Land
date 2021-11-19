import "package:flutter/material.dart";
import "package:hollyday_land/models/winery/winery_short.dart";
import "package:hollyday_land/screens/winery/winery.dart";
import "package:hollyday_land/widgets/list_item.dart";

class WineryListItem extends AttractionListItem<WineryShort> {
  const WineryListItem({Key? key, required WineryShort winery})
      : super(key: key, attraction: winery);

  @override
  List<Widget> extraInformation(BuildContext context) {
    return [];
  }

  @override
  MaterialPageRoute get pageRoute =>
      MaterialPageRoute(builder: (_) => WineryScreen(winery: attraction));
}
