import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land/models/filter_tag.dart";
import "package:hollyday_land_dao/filter_dao.dart";

part "attraction_type.objects.filter_tags.dart";

@FilterTagDao("rock_climbing_types")
class RockClimbingAttractionType with FilterTag {
  @override
  final int id;
  @override
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
}
