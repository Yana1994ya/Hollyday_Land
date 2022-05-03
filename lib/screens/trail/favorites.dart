import "package:flutter/material.dart";
import "package:hollyday_land/models/trail/short.dart";
import "package:hollyday_land/providers/favorites_cache_key.dart";
import "package:hollyday_land/screens/user_attractions.dart";
import "package:hollyday_land/widgets/list_item.dart";
import "package:hollyday_land/widgets/trail/trail_list_item.dart";
import "package:provider/provider.dart";

class FavoritesTrailsScreen extends UserAttractionsScreen<TrailShort> {
  static const routePath = "/favorites/trails";

  @override
  AttractionListItem<TrailShort> getListItem(TrailShort attraction) {
    return TrailListItem(
      attraction: attraction,
    );
  }

  @override
  String itemCountText(List<TrailShort> attractions) {
    return "favorite ${attractions.length} trails";
  }

  @override
  Future<List<TrailShort>> readAttractions(
    String hdToken,
    BuildContext context,
  ) {
    final cacheKeyProvider = Provider.of<FavoritesCacheKey>(context);
    return trailShortObjects.readFavorites(hdToken, cacheKeyProvider.cacheKey);
  }

  @override
  String get pageTitle => "Favorite trails";
}
