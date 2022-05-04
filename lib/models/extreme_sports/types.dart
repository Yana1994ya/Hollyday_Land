import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land/models/filter_tag.dart";
import "package:hollyday_land_dao/filter_dao.dart";

part "types.objects.filter_tags.dart";

@FilterTagDao("extreme_sports_types")
class ExtremeSportsType with FilterTag {
  @override
  final int id;

  @override
  final String name;

  ExtremeSportsType({required this.id, required this.name});

  factory ExtremeSportsType.fromJson(Map<String, dynamic> json) {
    return ExtremeSportsType(
      id: json["id"],
      name: json["name"],
    );
  }

  @override
  String toString() {
    return "ExtremeSportsType{id: $id, name: $name}";
  }
}
