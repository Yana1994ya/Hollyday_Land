import "package:flutter/material.dart";
import "package:hollyday_land/models/winery/short.dart";
import "package:hollyday_land/providers/favorites_cache_key.dart";
import "package:hollyday_land/screens/user_attractions.dart";
import "package:hollyday_land/widgets/list_item.dart";
import "package:hollyday_land/widgets/winery/list_item.dart";
import "package:provider/provider.dart";

class FavoritesWineriesScreen extends UserAttractionsScreen<WineryShort> {
  static const routePath = "/favorites/wineries";

  @override
  AttractionListItem<WineryShort> getListItem(WineryShort attraction) {
    return WineryListItem(winery: attraction);
  }

  @override
  String itemCountText(List<WineryShort> attractions) {
    return "favorite ${attractions.length} wineries";
  }

  @override
  Future<List<WineryShort>> readAttractions(
    String hdToken,
    BuildContext context,
  ) {
    final cacheKeyProvider = Provider.of<FavoritesCacheKey>(context);
    return WineryShort.readFavorites(hdToken, cacheKeyProvider.cacheKey);
  }

  @override
  String get pageTitle => "Favorite wineries";
}
