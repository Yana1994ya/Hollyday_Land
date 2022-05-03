import "package:flutter/material.dart";
import "package:hollyday_land/models/hot_air/short.dart";
import "package:hollyday_land/screens/hot_air/hot_air.dart";
import "package:hollyday_land/widgets/managed_list_item.dart";

class HotAirListItem extends ManagedAttractionListItem<HotAirShort> {
  const HotAirListItem({Key? key, required HotAirShort attraction})
      : super(key: key, attraction: attraction);

  @override
  MaterialPageRoute get pageRoute =>
      MaterialPageRoute(builder: (_) => HotAirScreen(attraction: attraction));
}
