import "package:flutter/material.dart";
import "package:hollyday_land/models/zoo/short.dart";
import "package:hollyday_land/providers/favorites_cache_key.dart";
import "package:hollyday_land/screens/user_attractions.dart";
import "package:hollyday_land/widgets/list_item.dart";
import "package:hollyday_land/widgets/zoo/list_item.dart";
import "package:provider/provider.dart";

class FavoritesZoosScreen extends UserAttractionsScreen<ZooShort> {
  static const routePath = "/favorites/zoos";

  @override
  AttractionListItem<ZooShort> getListItem(ZooShort attraction) {
    return ZooListItem(zoo: attraction);
  }

  @override
  String itemCountText(List<ZooShort> attractions) {
    return "favorite ${attractions.length} zoos";
  }

  @override
  Future<List<ZooShort>> readAttractions(
    String hdToken,
    BuildContext context,
  ) {
    final cacheKeyProvider = Provider.of<FavoritesCacheKey>(context);
    return ZooShort.readFavorites(hdToken, cacheKeyProvider.cacheKey);
  }

  @override
  String get pageTitle => "Favorite zoos";
}
