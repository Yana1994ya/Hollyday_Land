import "package:flutter/material.dart";
import "package:hollyday_land/models/dao/base_attraction_short.dart";
import "package:hollyday_land/models/zoo/zoo.dart";
import "package:hollyday_land/providers/rating.dart";
import "package:hollyday_land/screens/managed_attraction.dart";
import "package:provider/provider.dart";

class ZooScreen extends ManagedAttractionScreen<Zoo> {
  const ZooScreen({Key? key, required AttractionShort attraction})
      : super(key: key, attraction: attraction);

  @override
  Future<Zoo> readFull(BuildContext context) {
    final ratingCacheKey = Provider.of<RatingCacheKey>(context).cacheKey;
    return zooObjects.read(attraction.id, ratingCacheKey);
  }
}
