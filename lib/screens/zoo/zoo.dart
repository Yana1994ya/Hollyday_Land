import "package:flutter/material.dart";
import "package:hollyday_land/models/base_attraction.dart";
import "package:hollyday_land/models/zoo/zoo.dart";
import "package:hollyday_land/providers/rating.dart";
import "package:hollyday_land/screens/attraction.dart";
import "package:provider/provider.dart";

class ZooScreen extends AttractionScreen<Zoo> {
  const ZooScreen({Key? key, required BaseAttraction attraction})
      : super(key: key, attraction: attraction);

  @override
  Future<Zoo> readFull(BuildContext context) {
    final ratingCacheKey = Provider.of<RatingCacheKey>(context).cacheKey;
    return Zoo.readZoo(attraction.id, ratingCacheKey);
  }
}
