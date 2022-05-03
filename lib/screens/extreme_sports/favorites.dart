import "package:flutter/material.dart";
import "package:hollyday_land/models/extreme_sports/short.dart";
import "package:hollyday_land/providers/favorites_cache_key.dart";
import "package:hollyday_land/screens/user_attractions.dart";
import "package:hollyday_land/widgets/extreme_sports/list_item.dart";
import "package:hollyday_land/widgets/list_item.dart";
import "package:provider/provider.dart";

class FavoritesExtremeSportsScreen
    extends UserAttractionsScreen<ExtremeSportsShort> {
  static const routePath = "/favorites/extreme_sports";

  @override
  AttractionListItem<ExtremeSportsShort> getListItem(
      ExtremeSportsShort attraction) {
    return ExtremeSportsListItem(attraction: attraction);
  }

  @override
  String itemCountText(List<ExtremeSportsShort> attractions) {
    return "favorite ${attractions.length} extreme sports attractions";
  }

  @override
  Future<List<ExtremeSportsShort>> readAttractions(
    String hdToken,
    BuildContext context,
  ) {
    final cacheKeyProvider = Provider.of<FavoritesCacheKey>(context);
    return extremeSportsShortObjects.readFavorites(
        hdToken, cacheKeyProvider.cacheKey);
  }

  @override
  String get pageTitle => "Favorite extreme sports attractions";
}
