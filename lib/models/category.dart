import 'dart:convert';

import 'package:http/http.dart' as http;

class RootCategory {
  final Category category;
  final List<Category> subCategories;

  const RootCategory(this.category, this.subCategories);
}

class Category {
  final int id;
  final String title;
  final String? image;

  const Category({
    required this.id,
    required this.title,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['id'], title: json['name'], image: json['image']);
  }

  static Future<List<Category>> _fetchCategories(int? categoryId) async {
    final idName = categoryId != null ? categoryId.toString() : "root";
    final url =
        "https://hollyland.iywebs.cloudns.ph/attractions/category/$idName.json";
    print("fetching: $url");

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((m) => Category.fromJson(m)).toList();
    } else {
      throw Exception("failed to load data, status: ${response.statusCode}");
    }
  }

  static Future<List<Category>> fetchSubCategories(Category category) {
    return _fetchCategories(category.id);
  }

  static Future<RootCategory> _resolveRoot(Category category) async {
    List<Category> subCategories = await fetchSubCategories(category);

    return RootCategory(category, subCategories);
  }

  static Future<List<RootCategory>> fetchRootCategories() async {
    List<Category> rootCategories = await _fetchCategories(null);

    return await Future.wait(rootCategories.map(_resolveRoot));
  }
}
