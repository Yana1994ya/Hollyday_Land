import "package:hollyday_land/api_server.dart";

class Favorites {
  final int museums;

  Favorites({required this.museums});

  factory Favorites.fromJson(Map<String, dynamic> json) {
    return Favorites(museums: json["museums"]);
  }

  static Future<Favorites> readFavorites(String token) async {
    return ApiServer.post(
      "/attractions/api/favorites",
      "favorites",
      {"token": token},
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
