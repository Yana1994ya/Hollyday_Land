import "package:flutter/material.dart";
import "package:hollyday_land/models/offroad/short.dart";
import "package:hollyday_land/providers/favorites_cache_key.dart";
import "package:hollyday_land/screens/user_attractions.dart";
import "package:hollyday_land/widgets/list_item.dart";
import "package:hollyday_land/widgets/offroad/list_item.dart";
import "package:provider/provider.dart";

class FavoritesOffRoadTripsScreen
    extends UserAttractionsScreen<OffRoadTripShort> {
  static const routePath = "/favorites/off_road_trips";

  @override
  AttractionListItem<OffRoadTripShort> getListItem(
      OffRoadTripShort attraction) {
    return OffRoadTripListItem(trip: attraction);
  }

  @override
  String itemCountText(List<OffRoadTripShort> attractions) {
    return "favorite ${attractions.length} off road trips";
  }

  @override
  Future<List<OffRoadTripShort>> readAttractions(
    String hdToken,
    BuildContext context,
  ) {
    final cacheKeyProvider = Provider.of<FavoritesCacheKey>(context);
    return OffRoadTripShort.readFavorites(hdToken, cacheKeyProvider.cacheKey);
  }

  @override
  String get pageTitle => "Favorite Off Road trips";
}
