import "dart:convert";

import "package:hollyday_land/models/http_exception.dart";
import "package:http/http.dart" as http;

class ApiServer {
  static const serverName = "hollyland.iywebs.cloudns.ph";

  /*static Uri getUri(String path, [Map<String, Iterable<String>>? queryParameters]) =>
    Uri.https(serverName, path, queryParameters);*/

  static Uri getUri(String path,
          [Map<String, Iterable<String>>? queryParameters]) =>
      Uri.http("192.168.1.122:8000", path, queryParameters);

  static Future<dynamic> get(String path, String field,
      [Map<String, Iterable<String>>? queryParameters]) async {
    final uri = getUri(path, queryParameters);

    print("fetching: $uri");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data["status"] == "ok") {
        return data[field];
      } else {
        throw HttpException("error was returned:${data["error"]}");
      }
    } else {
      throw HttpException(
        "failed to load data, status: ${response.statusCode}",
      );
    }
  }

  static Future<dynamic> post(
      String path, String field, Map<String, dynamic> body) async {
    final uri = getUri(path);

    print("fetching: $uri");
    print(body);

    final response = await http.post(
      uri,
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8"
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data["status"] == "ok") {
        return data[field];
      } else {
        throw BadRequest(
          code: data["code"],
          message: data["message"],
        );
      }
    } else {
      throw HttpException(
        "failed to load data, status: ${response.statusCode}",
      );
    }
  }

  static Future<void> voidPost(String path, Map<String, dynamic> body) async {
    final uri = getUri(path);

    print("fetching: $uri");

    final response = await http.post(
      uri,
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8"
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data["status"] != "ok") {
        throw HttpException("error was returned:${data["error"]}");
      }
    } else {
      throw HttpException(
        "failed to load data, status: ${response.statusCode}",
      );
    }
  }
}
