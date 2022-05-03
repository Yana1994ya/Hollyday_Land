import "package:hollyday_land/api_server.dart";
import "package:hollyday_land/models/attractions_count.dart";

class Favorites {
  static Future<AttractionsCount> readFavorites(
      String token, int cacheKey) async {
    return ApiServer.post(
      "/attractions/api/favorites",
      "favorites",
      {
        "token": token,
        "cache_key": cacheKey,
      },
    ).then((favorites) => AttractionsCount.fromJson(favorites));
  }

  static Future<bool> readFavorite(String token, int attractionId) async {
    return ApiServer.post(
      "/attractions/api/favorite",
      "value",
      {
        "token": token,
        "id": attractionId,
      },
    ).then((value) => (value as bool));
  }

  static Future<void> setFavorite(
      String token, int attractionId, bool value) async {
    return ApiServer.voidPost(
      "/attractions/api/favorite",
      {
        "token": token,
        "id": attractionId,
        "value": value,
      },
    );
  }
}
