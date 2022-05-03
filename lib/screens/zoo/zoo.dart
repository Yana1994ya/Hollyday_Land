import "package:flutter/material.dart";
import "package:hollyday_land/models/dao/base_attraction_short.dart";
import "package:hollyday_land/models/zoo/zoo.dart";
import "package:hollyday_land/screens/managed_attraction.dart";

class ZooScreen extends ManagedAttractionScreen<Zoo> {
  const ZooScreen({Key? key, required AttractionShort attraction})
      : super(key: key, attraction: attraction);

  @override
  Future<Zoo> readFull(BuildContext context, int cacheKey) {
    return zooObjects.read(attraction.id, cacheKey);
  }
}
