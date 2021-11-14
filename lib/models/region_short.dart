import 'package:hollyday_land/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegionShort {
  final int id;
  final String name;

  RegionShort({
    required this.id,
    required this.name,
  });

  factory RegionShort.fromJson(Map<String, dynamic> json) {
    return RegionShort(
      id: json['id'],
      name: json['name'],
    );
  }

  static Future<List<RegionShort>> readRegions() async {
    final uri = Uri.https(
      API_SERVER,
      "/attractions/api/regions",
    );

    print("fetching: $uri");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data["status"] == "ok") {
        final List<dynamic> regions = data["regions"];
        return regions.map((e) => RegionShort.fromJson(e)).toList();
      } else {
        throw Exception("error was returned:${data["error"]}");
      }
    } else {
      throw Exception("failed to load data, status: ${response.statusCode}");
    }
  }

  @override
  String toString() {
    return 'RegionShort{id: $id, name: $name}';
  }
}
