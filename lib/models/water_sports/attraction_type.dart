import "package:hollyday_land/api_server.dart";

class WaterSportsAttractionType {
  final int id;
  final String name;

  WaterSportsAttractionType({required this.id, required this.name});

  factory WaterSportsAttractionType.fromJson(Map<String, dynamic> json) {
    return WaterSportsAttractionType(
      id: json["id"],
      name: json["name"],
    );
  }

  @override
  String toString() {
    return "WaterSportsAttractionType{id: $id, name: $name}";
  }

  static List<WaterSportsAttractionType> _mapAttractionType(dynamic apiResult) {
    return (apiResult as List<dynamic>)
        .map((domain) => WaterSportsAttractionType.fromJson(domain))
        .toList();
  }

  static Future<List<WaterSportsAttractionType>> readAttractionTypes() async {
    return ApiServer.get(
      "/attractions/api/water_sport_types",
      "water_sports_attraction_types",
    ).then(_mapAttractionType);
  }
}
