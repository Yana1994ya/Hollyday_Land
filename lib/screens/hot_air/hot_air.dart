import "package:flutter/material.dart";
import "package:hollyday_land/models/dao/base_attraction_short.dart";
import "package:hollyday_land/models/hot_air/hot_air.dart";
import "package:hollyday_land/screens/managed_attraction.dart";

class HotAirScreen extends ManagedAttractionScreen<HotAir> {
  const HotAirScreen({Key? key, required AttractionShort attraction})
      : super(key: key, attraction: attraction);

  @override
  Future<HotAir> readFull(BuildContext context, int cacheKey) {
    return hotAirObjects.read(attraction.id, cacheKey);
  }
}
