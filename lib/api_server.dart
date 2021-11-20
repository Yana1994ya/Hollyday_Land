import "dart:convert";

import "package:hollyday_land/models/http_exception.dart";
import "package:http/http.dart" as http;

class ApiServer {
  static const serverName = "hollyland.iywebs.cloudns.ph";

  static Future<dynamic> get(String path, String field,
      [Map<String, Iterable<String>>? queryParameters]) async {
    final uri = Uri.https(serverName, path, queryParameters);

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
    final uri = Uri.https(serverName, path);

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
        throw HttpException("error was returned:${data["error"]}");
      }
    } else {
      throw HttpException(
        "failed to load data, status: ${response.statusCode}",
      );
    }
  }

  static Future<void> voidPost(String path, Map<String, dynamic> body) async {
    final uri = Uri.https(serverName, path);

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
