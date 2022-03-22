import "package:flutter/material.dart";
import "package:hollyday_land/models/museum/short.dart";
import "package:hollyday_land/providers/favorites_cache_key.dart";
import "package:hollyday_land/screens/user_attractions.dart";
import "package:hollyday_land/widgets/list_item.dart";
import "package:hollyday_land/widgets/museum/list_item.dart";
import "package:provider/provider.dart";

class FavoritesMuseumsScreen extends UserAttractionsScreen<MuseumShort> {
  static const routePath = "/favorites/museums";

  @override
  AttractionListItem<MuseumShort> getListItem(MuseumShort attraction) {
    return MuseumListItem(museum: attraction);
  }

  @override
  String itemCountText(List<MuseumShort> attractions) {
    return "favorite ${attractions.length} museums";
  }

  @override
  Future<List<MuseumShort>> readAttractions(
    String hdToken,
    BuildContext context,
  ) {
    final cacheKeyProvider = Provider.of<FavoritesCacheKey>(context);
    return museumShortObjects.readFavorites(hdToken, cacheKeyProvider.cacheKey);
  }

  @override
  String get pageTitle => "Favorite museums";
}
