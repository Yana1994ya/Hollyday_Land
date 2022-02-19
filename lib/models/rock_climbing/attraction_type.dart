import "package:hollyday_land/api_server.dart";

class RockClimbingAttractionType {
  final int id;
  final String name;

  RockClimbingAttractionType({required this.id, required this.name});

  factory RockClimbingAttractionType.fromJson(Map<String, dynamic> json) {
    return RockClimbingAttractionType(
      id: json["id"],
      name: json["name"],
    );
  }

  @override
  String toString() {
    return "RockClimbingAttractionType{id: $id, name: $name}";
  }

  static List<RockClimbingAttractionType> _mapAttractionType(
      dynamic apiResult) {
    return (apiResult as List<dynamic>)
        .map((domain) => RockClimbingAttractionType.fromJson(domain))
        .toList();
  }

  static Future<List<RockClimbingAttractionType>> readAttractionTypes() async {
    return ApiServer.get(
      "/attractions/api/rock_climbing_types",
      "rock_climbing_types",
    ).then(_mapAttractionType);
  }
}
