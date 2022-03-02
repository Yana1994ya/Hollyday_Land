import "package:flutter/material.dart";
import "package:hollyday_land/models/water_sports/short.dart";
import "package:hollyday_land/providers/favorites_cache_key.dart";
import "package:hollyday_land/screens/user_attractions.dart";
import "package:hollyday_land/widgets/list_item.dart";
import "package:hollyday_land/widgets/water_sports/list_item.dart";
import "package:provider/provider.dart";

class FavoritesWaterSportsScreen
    extends UserAttractionsScreen<WaterSportsShort> {
  static const routePath = "/favorites/water_sports";

  @override
  AttractionListItem<WaterSportsShort> getListItem(
      WaterSportsShort attraction) {
    return WaterSportsListItem(attraction: attraction);
  }

  @override
  String itemCountText(List<WaterSportsShort> attractions) {
    return "favorite ${attractions.length} water sports attractions";
  }

  @override
  Future<List<WaterSportsShort>> readAttractions(
    String hdToken,
    BuildContext context,
  ) {
    final cacheKeyProvider = Provider.of<FavoritesCacheKey>(context);
    return WaterSportsShort.readFavorites(hdToken, cacheKeyProvider.cacheKey);
  }

  @override
  String get pageTitle => "Favorite water sports attractions";
}
