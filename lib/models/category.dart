import 'dart:convert';

import 'package:http/http.dart' as http;

import 'image_asset.dart';

class RootCategory {
  final Category category;
  final List<Category> subCategories;

  const RootCategory(this.category, this.subCategories);
}

class Category {
  final int id;
  final String title;
  final ImageAsset? image;
  final int? parentId;

  const Category({
    required this.id,
    required this.title,
    required this.image,
    required this.parentId,
  });

  factory Category.fromJson(int? parentId, Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['name'],
      image: json['image'] == null ? null : ImageAsset.fromJson(json['image']),
      parentId: parentId,
    );
  }

  static Future<List<Category>> _fetchCategories(int? categoryId) async {
    final idName = categoryId != null ? categoryId.toString() : "root";
    final url =
        "https://hollyland.iywebs.cloudns.ph/attractions/category/$idName.json";
    print("fetching: $url");

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((m) => Category.fromJson(categoryId, m)).toList();
    } else {
      throw Exception("failed to load data, status: ${response.statusCode}");
    }
  }

  static Future<List<Category>> fetchCategoriesFor(
    List<int> selectedCategories,
    List<int> parentIds,
  ) async {
    final int firstParent = parentIds[0];

    final Map<String, dynamic> params = {
      "category_id": selectedCategories.map((cat) => cat.toString()).toList()
    };

    final uri = Uri.https(
      "hollyland.iywebs.cloudns.ph",
      "/attractions/category/$firstParent.json",
      params,
    );

    print("fetching: $uri");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<Category> results =
          data.map((m) => Category.fromJson(firstParent, m)).toList();

      if (parentIds.length == 1) {
        return results;
      } else {
        return results +
            await fetchCategoriesFor(selectedCategories, parentIds.sublist(1));
      }
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
    // Fetch root categories
    List<Category> rootCategories = await _fetchCategories(null);

    // Fetch sub-categories for those root categories, and return everything under
    // a single future.
    return await Future.wait(rootCategories.map(_resolveRoot));
  }
}
