import "package:flutter/material.dart";
import "package:hollyday_land/models/hot_air/short.dart";
import "package:hollyday_land/providers/favorites_cache_key.dart";
import "package:hollyday_land/screens/user_attractions.dart";
import "package:hollyday_land/widgets/hot_air/list_item.dart";
import "package:hollyday_land/widgets/list_item.dart";
import "package:provider/provider.dart";

class FavoritesHotAirScreen extends UserAttractionsScreen<HotAirShort> {
  static const routePath = "/favorites/hot_air";

  @override
  AttractionListItem<HotAirShort> getListItem(HotAirShort attraction) {
    return HotAirListItem(
      attraction: attraction,
    );
  }

  @override
  String itemCountText(List<HotAirShort> attractions) {
    return "favorite ${attractions.length} hot air balloon attractions";
  }

  @override
  Future<List<HotAirShort>> readAttractions(
    String hdToken,
    BuildContext context,
  ) {
    final cacheKeyProvider = Provider.of<FavoritesCacheKey>(context);
    return hotAirShortObjects.readFavorites(hdToken, cacheKeyProvider.cacheKey);
  }

  @override
  String get pageTitle => "Favorite hot air balloon attractions";
}
