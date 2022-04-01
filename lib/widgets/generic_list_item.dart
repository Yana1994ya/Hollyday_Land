import "package:flutter/material.dart";
import 'package:hollyday_land/models/generic_attraction.dart';
import "package:hollyday_land/widgets/list_item.dart";

class GenericListItem extends AttractionListItem<GenericAttraction> {
  const GenericListItem({Key? key, required GenericAttraction attraction})
      : super(key: key, attraction: attraction);

  @override
  List<Widget> extraInformation(BuildContext context) {
    return [];
  }

  @override
  MaterialPageRoute get pageRoute =>
      MaterialPageRoute(builder: (_) => attraction.page);
}
