import "package:hollyday_land/api_server.dart";

class Favorites {
  final int museums;
  final int wineries;
  final int zoos;
  final int offRoadTrips;

  Favorites({
    required this.museums,
    required this.wineries,
    required this.zoos,
    required this.offRoadTrips,
  });

  factory Favorites.fromJson(Map<String, dynamic> json) {
    return Favorites(
      museums: json["museums"],
      wineries: json["wineries"],
      zoos: json["zoos"],
      offRoadTrips: json["off_road"],
    );
  }

  static Future<Favorites> readFavorites(String token, int cacheKey) async {
    return ApiServer.post(
      "/attractions/api/favorites",
      "favorites",
      {
        "token": token,
        "cache_key": cacheKey,
      },
    ).then((favorites) => Favorites.fromJson(favorites));
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
