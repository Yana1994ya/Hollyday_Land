import "package:flutter/material.dart";
import "package:hollyday_land/models/dao/base_attraction_short.dart";
import "package:hollyday_land/models/rock_climbing/item.dart";
import "package:hollyday_land/screens/managed_attraction.dart";

class RockClimbingItemScreen extends ManagedAttractionScreen<RockClimbingItem> {
  const RockClimbingItemScreen({Key? key, required AttractionShort attraction})
      : super(key: key, attraction: attraction);

  @override
  Future<RockClimbingItem> readFull(BuildContext context, int cacheKey) {
    return rockClimbingItemObjects.read(attraction.id, cacheKey);
  }

  @override
  List<Widget> extraInformation(
      RockClimbingItem attraction, BuildContext context) {
    return [
      SizedBox(height: 5),
      Align(
        child: Text(attraction.attractionType.name),
        alignment: Alignment.topLeft,
      ),
    ];
  }
}
