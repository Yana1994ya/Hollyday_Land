import '../config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Favorites{
  final int museums;

  Favorites({ required this.museums });
  factory Favorites.fromJson(Map<String, dynamic> json) {
    return Favorites(
        museums: json['museums']
    );
  }

  static Future<Favorites> readFavorites(String token) async {
    final uri = Uri.https(API_SERVER, "/attractions/api/favorites");

    print("fetching: $uri");

    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'token': token
        },
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data["status"] == "ok") {
        return Favorites.fromJson(data["favorites"]);
      } else {
        throw Exception("error was returned:${data["error"]}");
      }
    } else {
      throw Exception("failed to load data, status: ${response.statusCode}");
    }
  }

  static Future<bool> readFavorite(String token, int attractionId) async{
    final uri = Uri.https(API_SERVER, "/attractions/api/favorite");

    print("fetching: $uri");

    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'token': token,
          'id': attractionId.toString(),
        },
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data["status"] != "ok") {
        throw Exception("error was returned:${data["error"]}");
      }

      return data["value"];
    } else {
      throw Exception("failed to load data, status: ${response.statusCode}");
    }
  }

  static Future<void> setFavorite(String token, int attractionId, bool value) async{
    final uri = Uri.https(API_SERVER, "/attractions/api/favorite");

    print("fetching: $uri");

    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          'token': token,
          'id': attractionId,
          'value': value,
        },
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data["status"] != "ok") {
        throw Exception("error was returned:${data["error"]}");
      }

      return data["value"];
    } else {
      throw Exception("failed to load data, status: ${response.statusCode}");
    }
  }
}