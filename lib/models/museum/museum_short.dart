import 'package:hollyday_land/models/image_asset.dart';
import 'package:hollyday_land/models/museum/museum_domain.dart';
import 'package:hollyday_land/models/region_short.dart';

import '../region.dart';

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
}
