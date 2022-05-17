import "package:flutter/material.dart";
import 'package:hollyday_land/models/tour/short.dart';
import "package:hollyday_land/providers/favorites_cache_key.dart";
import "package:hollyday_land/screens/user_attractions.dart";
import "package:hollyday_land/widgets/list_item.dart";
import 'package:hollyday_land/widgets/tour/tour_list_item.dart';
import "package:provider/provider.dart";

class FavoritesToursScreen extends UserAttractionsScreen<TourShort> {
  static const routePath = "/favorites/tours";

  @override
  AttractionListItem<TourShort> getListItem(TourShort attraction) {
    return TourListItem(attraction: attraction);
  }

  @override
  String itemCountText(List<TourShort> attractions) {
    return "favorite ${attractions.length} tours";
  }

  @override
  Future<List<TourShort>> readAttractions(
    String hdToken,
    BuildContext context,
  ) {
    final cacheKeyProvider = Provider.of<FavoritesCacheKey>(context);
    return tourShortObjects.readFavorites(hdToken, cacheKeyProvider.cacheKey);
  }

  @override
  String get pageTitle => "Favorite tours";
}
