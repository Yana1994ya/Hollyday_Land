import "package:hollyday_land/api_server.dart";
import "package:hollyday_land/models/image_asset.dart";

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
      id: json["id"],
      name: json["name"],
      image: json["image"] == null ? null : ImageAsset.fromJson(json["image"]),
    );
  }

  static Future<List<Region>> readRegions() async {
    return ApiServer.get("/attractions/api/regions", "regions").then((data) =>
        (data as List<dynamic>)
            .map((region) => Region.fromJson(region))
            .toList());
  }

  @override
  String toString() {
    return "Region{id: $id, name: $name, image: $image}";
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
