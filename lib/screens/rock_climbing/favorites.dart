import "package:flutter/material.dart";
import "package:hollyday_land/models/rock_climbing/short.dart";
import "package:hollyday_land/providers/favorites_cache_key.dart";
import "package:hollyday_land/screens/user_attractions.dart";
import "package:hollyday_land/widgets/list_item.dart";
import "package:hollyday_land/widgets/rock_climbing/list_item.dart";
import "package:provider/provider.dart";

class FavoritesRockClimbingScreen
    extends UserAttractionsScreen<RockClimbingShort> {
  static const routePath = "/favorites/rock_climbing";

  @override
  AttractionListItem<RockClimbingShort> getListItem(
      RockClimbingShort attraction) {
    return RockClimbingListItem(attraction: attraction);
  }

  @override
  String itemCountText(List<RockClimbingShort> attractions) {
    return "favorite ${attractions.length} rock climbing attractions";
  }

  @override
  Future<List<RockClimbingShort>> readAttractions(
    String hdToken,
    BuildContext context,
  ) {
    final cacheKeyProvider = Provider.of<FavoritesCacheKey>(context);
    return rockClimbingShortObjects.readFavorites(
        hdToken, cacheKeyProvider.cacheKey);
  }

  @override
  String get pageTitle => "Favorite rock climbing attractions";
}
