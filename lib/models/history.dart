import "package:hollyday_land/api_server.dart";

class History {
  final int museums;
  final int wineries;
  final int zoos;

  History({required this.museums, required this.wineries, required this.zoos});

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      museums: json["museums"],
      wineries: json["wineries"],
      zoos: json["zoos"],
    );
  }

  static Future<void> deleteHistory(String token) async {
    return ApiServer.voidPost(
      "/attractions/api/history/delete",
      {"token": token},
    );
  }

  static Future<History> readHistory(String token) async {
    return ApiServer.post(
      "/attractions/api/history",
      "visited",
      {"token": token},
    ).then((data) => History.fromJson(data));
  }
}
