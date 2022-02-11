import "package:hollyday_land/api_server.dart";

class TrailSuitability {
  final int id;
  final String name;

  const TrailSuitability({required this.id, required this.name});

  factory TrailSuitability.fromJson(Map<String, dynamic> json) {
    return TrailSuitability(
      id: json["id"],
      name: json["name"],
    );
  }

  @override
  String toString() {
    return "TrailSuitability{id: $id, name: $name}";
  }

  static List<TrailSuitability> _mapSuitabilityTypes(dynamic apiResult) {
    return (apiResult as List<dynamic>)
        .map((suitability) => TrailSuitability.fromJson(suitability))
        .toList();
  }

  static Future<List<TrailSuitability>> readSuitabilities() async {
    return ApiServer.get(
      "/attractions/api/trails/suitabilities",
      "trail_suitabilities",
    ).then(_mapSuitabilityTypes);
  }
}
