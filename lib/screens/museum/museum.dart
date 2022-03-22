import "package:flutter/material.dart";
import "package:hollyday_land/models/dao/base_attraction_short.dart";
import "package:hollyday_land/models/museum/museum.dart";
import "package:hollyday_land/providers/rating.dart";
import 'package:hollyday_land/screens/managed_attraction.dart';
import "package:provider/provider.dart";

class MuseumScreen extends ManagedAttractionScreen<Museum> {
  const MuseumScreen({Key? key, required AttractionShort attraction})
      : super(key: key, attraction: attraction);

  @override
  Future<Museum> readFull(BuildContext context) {
    final ratingCacheKey = Provider.of<RatingCacheKey>(context).cacheKey;
    return museumObjects.read(attraction.id, ratingCacheKey);
  }
}
