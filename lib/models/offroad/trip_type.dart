import "package:hollyday_land/api_server.dart";
import "package:hollyday_land/models/filter_tag.dart";

class TripType with FilterTag {
  @override
  final int id;
  @override
  final String name;

  TripType({required this.id, required this.name});

  factory TripType.fromJson(Map<String, dynamic> json) {
    return TripType(
      id: json["id"],
      name: json["name"],
    );
  }

  @override
  String toString() {
    return "TripType{id: $id, name: $name}";
  }

  static List<TripType> _mapTripTypes(dynamic apiResult) {
    return (apiResult as List<dynamic>)
        .map((domain) => TripType.fromJson(domain))
        .toList();
  }

  static Future<List<TripType>> readTripTypes() async {
    return ApiServer.get(
      "/attractions/api/off_road_trip_types",
      "trip_types",
    ).then(_mapTripTypes);
  }
}
