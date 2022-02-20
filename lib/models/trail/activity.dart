import "package:hollyday_land/api_server.dart";
import "package:hollyday_land/models/filter_tag.dart";

class TrailActivity with FilterTag {
  @override
  final int id;
  @override
  final String name;

  const TrailActivity({required this.id, required this.name});

  factory TrailActivity.fromJson(Map<String, dynamic> json) {
    return TrailActivity(
      id: json["id"],
      name: json["name"],
    );
  }

  @override
  String toString() {
    return "TrailActivity{id: $id, name: $name}";
  }

  static List<TrailActivity> _mapActivityTypes(dynamic apiResult) {
    return (apiResult as List<dynamic>)
        .map((suitability) => TrailActivity.fromJson(suitability))
        .toList();
  }

  static Future<List<TrailActivity>> readActivities() async {
    return ApiServer.get(
      "/attractions/api/trails/activities",
      "trail_activities",
    ).then(_mapActivityTypes);
  }
}
