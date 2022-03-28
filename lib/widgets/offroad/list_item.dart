import "package:flutter/material.dart";
import "package:hollyday_land/models/offroad/short.dart";
import "package:hollyday_land/screens/offroad/trip.dart";
import "package:hollyday_land/widgets/managed_list_item.dart";

class OffRoadTripListItem extends ManagedAttractionListItem<OffRoadTripShort> {
  const OffRoadTripListItem({Key? key, required OffRoadTripShort trip})
      : super(key: key, attraction: trip);

  @override
  List<Widget> extraInformation(BuildContext context) {
    return super.extraInformation(context) +
        [
          Align(
            child: Text(attraction.tripType.name),
            alignment: Alignment.topLeft,
          )
        ];
  }

  @override
  MaterialPageRoute get pageRoute => MaterialPageRoute(
      builder: (_) => OffRoadTripScreen(attraction: attraction));
}
