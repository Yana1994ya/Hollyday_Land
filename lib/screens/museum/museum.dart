import "package:flutter/material.dart";
import "package:hollyday_land/models/base_attraction.dart";
import "package:hollyday_land/models/museum/museum.dart";
import "package:hollyday_land/providers/rating.dart";
import "package:hollyday_land/screens/attraction.dart";
import "package:provider/provider.dart";

class MuseumScreen extends AttractionScreen<Museum> {
  const MuseumScreen({Key? key, required BaseAttraction attraction})
      : super(key: key, attraction: attraction);

  @override
  Future<Museum> readFull(BuildContext context) {
    final ratingCacheKey = Provider.of<RatingCacheKey>(context).cacheKey;
    return Museum.readMuseum(attraction.id, ratingCacheKey);
  }
}
