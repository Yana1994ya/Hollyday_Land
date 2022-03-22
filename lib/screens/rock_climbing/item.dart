import "package:flutter/material.dart";
import "package:hollyday_land/models/dao/base_attraction_short.dart";
import "package:hollyday_land/models/rock_climbing/item.dart";
import "package:hollyday_land/providers/rating.dart";
import "package:hollyday_land/screens/attraction.dart";
import "package:provider/provider.dart";

class RockClimbingItemScreen extends AttractionScreen<RockClimbingItem> {
  const RockClimbingItemScreen({Key? key, required AttractionShort attraction})
      : super(key: key, attraction: attraction);

  @override
  Future<RockClimbingItem> readFull(BuildContext context) {
    final ratingCacheKey = Provider.of<RatingCacheKey>(context).cacheKey;
    return rockClimbingItemObjects.read(attraction.id, ratingCacheKey);
  }
}
