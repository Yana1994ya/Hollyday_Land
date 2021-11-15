import "package:hollyday_land/api_server.dart";

class RegionShort {
  final int id;
  final String name;

  RegionShort({
    required this.id,
    required this.name,
  });

  factory RegionShort.fromJson(Map<String, dynamic> json) {
    return RegionShort(
      id: json["id"],
      name: json["name"],
    );
  }

  static Future<List<RegionShort>> readRegions() async {
    return ApiServer.get(
      "/attractions/api/regions",
      "regions",
    ).then((data) => (data as List<dynamic>)
        .map((region) => RegionShort.fromJson(region))
        .toList());
  }

  @override
  String toString() {
    return "RegionShort{id: $id, name: $name}";
  }
}
