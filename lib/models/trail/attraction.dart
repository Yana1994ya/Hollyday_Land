import "package:hollyday_land/api_server.dart";
import "package:hollyday_land/models/filter_tag.dart";

class TrailAttraction with FilterTag {
  @override
  final int id;
  @override
  final String name;

  const TrailAttraction({required this.id, required this.name});

  factory TrailAttraction.fromJson(Map<String, dynamic> json) {
    return TrailAttraction(
      id: json["id"],
      name: json["name"],
    );
  }

  @override
  String toString() {
    return "TrailAttraction{id: $id, name: $name}";
  }

  static List<TrailAttraction> _mapAttractionTypes(dynamic apiResult) {
    return (apiResult as List<dynamic>)
        .map((suitability) => TrailAttraction.fromJson(suitability))
        .toList();
  }

  static Future<List<TrailAttraction>> readAttractions() async {
    return ApiServer.get(
      "/attractions/api/trails/attractions",
      "trail_attractions",
    ).then(_mapAttractionTypes);
  }
}
