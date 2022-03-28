import "package:flutter/material.dart";
import "package:hollyday_land/models/winery/short.dart";
import "package:hollyday_land/screens/winery/winery.dart";
import "package:hollyday_land/widgets/managed_list_item.dart";

class WineryListItem extends ManagedAttractionListItem<WineryShort> {
  const WineryListItem({Key? key, required WineryShort winery})
      : super(key: key, attraction: winery);

  @override
  MaterialPageRoute get pageRoute =>
      MaterialPageRoute(builder: (_) => WineryScreen(attraction: attraction));
}
