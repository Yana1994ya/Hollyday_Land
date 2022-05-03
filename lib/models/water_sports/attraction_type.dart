import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land/models/filter_tag.dart";
import "package:hollyday_land_dao/filter_dao.dart";

part "attraction_type.objects.filter_tags.dart";

@FilterTagDao("water_sports_attraction_types")
class WaterSportsAttractionType with FilterTag {
  @override
  final int id;
  @override
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
}
