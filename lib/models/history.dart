import "package:hollyday_land/api_server.dart";
import "package:hollyday_land/models/attractions_count.dart";

class History {
  static Future<void> deleteHistory(String token) async {
    return ApiServer.voidPost(
      "/attractions/api/history/delete",
      {"token": token},
    );
  }

  static Future<AttractionsCount> readHistory(String token) async {
    return ApiServer.post(
      "/attractions/api/history",
      "visited",
      {"token": token},
    ).then((data) => AttractionsCount.fromJson(data));
  }
}
