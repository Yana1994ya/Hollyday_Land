import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/category.dart';

class Attraction {
  final int id;
  final String name;
  final String? image;

  const Attraction({required this.id, required this.name, required this.image});

  factory Attraction.fromJson(Map<String, dynamic> json) {
    return Attraction(id: json['id'], name: json['name'], image: json['image']);
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
