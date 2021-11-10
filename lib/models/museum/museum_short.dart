import 'package:hollyday_land/models/image_asset.dart';
import 'package:hollyday_land/models/museum/museum_domain.dart';
import 'package:hollyday_land/models/museum/museum_filter.dart';
import 'package:hollyday_land/models/region_short.dart';

import '../../config.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class MuseumShort {
  final int id;
  final String name;
  final String address;
  final double lat;
  final double long;
  final ImageAsset? mainImage;
  final RegionShort region;
  final MuseumDomain domain;

  MuseumShort({
    required this.id,
    required this.name,
    required this.address,
    required this.lat,
    required this.long,
    required this.mainImage,
    required this.region,
    required this.domain,
  });

  factory MuseumShort.fromJson(Map<String, dynamic> json) {
    return MuseumShort(
      id: json['id'],
      name: json['name'],
      mainImage: json['main_image'] == null
          ? null
          : ImageAsset.fromJson(json["main_image"]),
      domain: MuseumDomain.fromJson(json["domain"]),
      region: RegionShort.fromJson(json["region"]),
      address: json["address"],
      long: json["long"],
      lat: json["lat"],
    );


  }

  @override
  String toString() {
    return 'MuseumShort{id: $id, name: $name, address: $address, lat: $lat, '
        'long: $long, mainImage: $mainImage, region: $region, domain: $domain}';
  }

  static Future<List<MuseumShort>> readMuseums(MuseumFilter museumFilter) async {
    final Map<String,Iterable<String>> parameters = {};

    if(museumFilter.regions.isNotEmpty){
      parameters["region_id"] = museumFilter.regions.map((id) => id.toString());
    }

    if(museumFilter.domains.isNotEmpty){
      parameters["domain_id"] = museumFilter.domains.map((id) => id.toString());
    }

    final uri = Uri.https(
      API_SERVER,
      "/attractions/api/museums",
      parameters
    );

    print("fetching: $uri");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data["status"] == "ok") {
        final List<dynamic> museums = data["museums"];
        return museums.map((e) => MuseumShort.fromJson(e)).toList();
      } else {
        throw Exception("error was returned:${data["error"]}");
      }
    } else {
      throw Exception("failed to load data, status: ${response.statusCode}");
    }
  }
}
