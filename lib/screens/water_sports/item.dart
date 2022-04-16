import "package:flutter/material.dart";
import "package:hollyday_land/models/dao/base_attraction_short.dart";
import "package:hollyday_land/models/water_sports/item.dart";
import "package:hollyday_land/screens/managed_attraction.dart";

class WaterSportsItemScreen extends ManagedAttractionScreen<WaterSportsItem> {
  const WaterSportsItemScreen({Key? key, required AttractionShort attraction})
      : super(key: key, attraction: attraction);

  @override
  Future<WaterSportsItem> readFull(BuildContext context, int cacheKey) {
    return waterSportsItemObjects.read(attraction.id, cacheKey);
  }

  @override
  List<Widget> extraInformation(
      WaterSportsItem attraction, BuildContext context) {
    return [
      SizedBox(height: 5),
      Align(
        child: Text(attraction.attractionType.name),
        alignment: Alignment.topLeft,
      ),
    ];
  }
}
