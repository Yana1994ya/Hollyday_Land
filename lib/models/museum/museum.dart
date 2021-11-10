import 'package:hollyday_land/models/image_asset.dart';
import 'package:hollyday_land/models/museum/museum_domain.dart';

import '../../config.dart';
import '../region.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class Museum {
  final int id;
  final String name;
  final String description;
  final String address;
  final String? website;
  final double lat;
  final double long;
  final ImageAsset? mainImage;
  final List<ImageAsset> additionalImages;
  final Region region;
  final MuseumDomain domain;

  Museum({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.website,
    required this.lat,
    required this.long,
    required this.mainImage,
    required this.additionalImages,
    required this.region,
    required this.domain,
  });

  factory Museum.fromJson(Map<String, dynamic> json) {
    final List<dynamic> additionalImagesJson = json["additional_images"];

    return Museum(
      id: json['id'],
      name: json['name'],
      mainImage: json['main_image'] == null
          ? null
          : ImageAsset.fromJson(json["main_image"]),
      additionalImages:
          additionalImagesJson.map((m) => ImageAsset.fromJson(m)).toList(),
      description: json["description"],
      domain: MuseumDomain.fromJson(json["domain"]),
      region: Region.fromJson(json["region"]),
      address: json["address"],
      website: json["website"],
      long: json["long"],
      lat: json["lat"],
    );
  }

  static Future<Museum> readMuseum(int museumId) async {
    final uri = Uri.https(
        API_SERVER,
        "/attractions/api/museums/$museumId"
    );

    print("fetching: $uri");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data["status"] == "ok") {
        return Museum.fromJson(data["museum"]);
      } else {
        throw Exception("error was returned:${data["error"]}");
      }
    } else {
      throw Exception("failed to load data, status: ${response.statusCode}");
    }
  }

  @override
  String toString() {
    return 'Museum{id: $id, name: $name, description: $description, '
        'address: $address, website: $website, lat: $lat, long: $long, '
        'mainImage: $mainImage, additionalImages: $additionalImages, '
        'region: $region, domain: $domain}';
  }
}
