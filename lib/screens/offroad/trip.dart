import "package:flutter/material.dart";
import "package:hollyday_land/models/dao/base_attraction_short.dart";
import "package:hollyday_land/models/offroad/offroad.dart";
import "package:hollyday_land/providers/rating.dart";
import "package:hollyday_land/screens/managed_attraction.dart";
import "package:provider/provider.dart";

class OffRoadTripScreen extends ManagedAttractionScreen<OffRoadTrip> {
  const OffRoadTripScreen({Key? key, required AttractionShort attraction})
      : super(key: key, attraction: attraction);

  @override
  Future<OffRoadTrip> readFull(BuildContext context) {
    final ratingCacheKey = Provider.of<RatingCacheKey>(context).cacheKey;

    return offRoadTripObjects.read(attraction.id, ratingCacheKey);
  }
}
