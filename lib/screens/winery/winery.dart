import "package:flutter/material.dart";
import "package:hollyday_land/models/dao/base_attraction_short.dart";
import "package:hollyday_land/models/winery/winery.dart";
import "package:hollyday_land/screens/managed_attraction.dart";

class WineryScreen extends ManagedAttractionScreen<Winery> {
  const WineryScreen({Key? key, required AttractionShort attraction})
      : super(key: key, attraction: attraction);

  @override
  Future<Winery> readFull(BuildContext context, int cacheKey) {
    return wineryObjects.read(attraction.id, cacheKey);
  }
}
