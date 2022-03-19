import "package:flutter/material.dart";
import "package:hollyday_land/models/base_attraction.dart";
import "package:hollyday_land/models/water_sports/item.dart";
import "package:hollyday_land/providers/rating.dart";
import "package:hollyday_land/screens/attraction.dart";
import "package:provider/provider.dart";

class WaterSportsItemScreen extends AttractionScreen<WaterSportsItem> {
  const WaterSportsItemScreen({Key? key, required BaseAttraction attraction})
      : super(key: key, attraction: attraction);

  @override
  Future<WaterSportsItem> readFull(BuildContext context) {
    final ratingCacheKey = Provider.of<RatingCacheKey>(context).cacheKey;
    return WaterSportsItem.readAttraction(attraction.id, ratingCacheKey);
  }
}
