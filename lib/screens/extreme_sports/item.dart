import "package:flutter/material.dart";
import "package:hollyday_land/models/dao/base_attraction_short.dart";
import "package:hollyday_land/models/extreme_sports/item.dart";
import "package:hollyday_land/screens/managed_attraction.dart";

class ExtremeSportsItemScreen extends ManagedAttractionScreen<ExtremeSports> {
  const ExtremeSportsItemScreen({Key? key, required AttractionShort attraction})
      : super(key: key, attraction: attraction);

  @override
  Future<ExtremeSports> readFull(BuildContext context, int cacheKey) {
    return extremeSportsObjects.read(attraction.id, cacheKey);
  }
}
