import "package:flutter/material.dart";
import "package:hollyday_land/models/zoo/short.dart";
import "package:hollyday_land/screens/zoo/zoo.dart";
import "package:hollyday_land/widgets/managed_list_item.dart";

class ZooListItem extends ManagedAttractionListItem<ZooShort> {
  const ZooListItem({Key? key, required ZooShort zoo})
      : super(key: key, attraction: zoo);

  @override
  MaterialPageRoute get pageRoute =>
      MaterialPageRoute(builder: (_) => ZooScreen(attraction: attraction));
}
