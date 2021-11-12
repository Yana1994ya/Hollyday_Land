import 'package:hollyday_land/providers/login.dart';
import 'package:http/http.dart' as http;

import '../config.dart';
import 'dart:convert';

class History {
  final int museums;

  History({ required this.museums });
  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      museums: json['museums']
    );
  }

  static Future<void> deleteHistory(String token) async {
    final uri = Uri.https(API_SERVER, "/attractions/api/history/delete");
    // final uri = Uri.http(API_SERVER, "/attractions/api/history/delete");


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

      if (data["status"] != "ok") {
        throw Exception("error was returned:${data["error"]}");
      }
    } else {
      throw Exception("failed to load data, status: ${response.statusCode}");
    }
  }


  static Future<History> readHistory(String token) async {
    final uri = Uri.https(API_SERVER, "/attractions/api/history");

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
        return History.fromJson(data["visited"]);
      } else {
        throw Exception("error was returned:${data["error"]}");
      }
    } else {
      throw Exception("failed to load data, status: ${response.statusCode}");
    }
  }
}