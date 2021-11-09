import 'package:hollyday_land/config.dart';
import 'package:hollyday_land/models/image_asset.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Region {
  final int id;
  final String name;
  final ImageAsset? image;

  Region({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      id: json['id'],
      name: json['name'],
      image: json['image'] == null ? null : ImageAsset.fromJson(json['image']),
    );
  }

  static Future<List<Region>> readRegions() async {
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
        return regions.map((e) => Region.fromJson(e)).toList();
      } else {
        throw Exception("error was returned:${data["error"]}");
      }
    } else {
      throw Exception("failed to load data, status: ${response.statusCode}");
    }
  }

  @override
  String toString() {
    return 'Region{id: $id, name: $name, image: $image}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Region &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          image == other.image;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ image.hashCode;
}
