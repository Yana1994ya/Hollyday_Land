import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/category.dart';

class ImageAsset {
  final String url;
  final int width;
  final int height;
  final int size;

  const ImageAsset(
      {required this.url,
      required this.width,
      required this.height,
      required this.size});

  factory ImageAsset.fromJson(Map<String, dynamic> json) {
    return ImageAsset(
        url: json["url"],
        width: json["width"],
        height: json["height"],
        size: json["size"]);
  }
}

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

  static Future<List<Attraction>> fetchAttractions(Category category) async {
    final url =
        "https://hollyland.iywebs.cloudns.ph/attractions/category/${category.id}.attractions.json";
    print("fetching: $url");

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((m) => Attraction.fromJson(m)).toList();
    } else {
      throw Exception("failed to load data, status: ${response.statusCode}");
    }
  }
}
