import "package:flutter/material.dart";
import "package:hollyday_land/models/dao/base_attraction_short.dart";
import "package:hollyday_land/models/offroad/offroad.dart";
import "package:hollyday_land/screens/managed_attraction.dart";

class OffRoadTripScreen extends ManagedAttractionScreen<OffRoadTrip> {
  const OffRoadTripScreen({
    Key? key,
    required AttractionShort attraction,
  }) : super(key: key, attraction: attraction);

  @override
  Future<OffRoadTrip> readFull(BuildContext context, int cacheKey) {
    return offRoadTripObjects.read(attraction.id, cacheKey);
  }

  @override
  List<Widget> extraInformation(OffRoadTrip attraction, BuildContext context) {
    return [
      SizedBox(height: 5),
      Align(
        child: Text(attraction.tripType.name),
        alignment: Alignment.topLeft,
      ),
    ];
  }
}
