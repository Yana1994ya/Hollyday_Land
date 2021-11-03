import 'dart:convert';

import 'package:http/http.dart' as http;

import 'image_asset.dart';

class Attraction {
  final int id;
  final String name;
  final ImageAsset? image;
  final List<ImageAsset> additionalImages;

  const Attraction({
    required this.id,
    required this.name,
    required this.image,
    required this.additionalImages,
  });

  factory Attraction.fromJson(Map<String, dynamic> json) {
    final List<dynamic> additionalImagesJson = json["additional"];

    return Attraction(
      id: json['id'],
      name: json['name'],
      image: json['image'] == null ? null : ImageAsset.fromJson(json["image"]),
      additionalImages:
          additionalImagesJson.map((m) => ImageAsset.fromJson(m)).toList(),
    );
  }

  static Future<List<Attraction>> fetchAttractions(
      List<int> categoryIds) async {
    final Map<String, dynamic> params = {
      "category_id": categoryIds.map((cat) => cat.toString()).toList()
    };

    final uri = Uri.https(
        "hollyland.iywebs.cloudns.ph", "/attractions/attractions.json", params);

    print("fetching: $uri");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((m) => Attraction.fromJson(m)).toList();
    } else {
      throw Exception("failed to load data, status: ${response.statusCode}");
    }
  }
}
