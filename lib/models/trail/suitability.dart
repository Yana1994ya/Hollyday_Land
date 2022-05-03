import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land/models/filter_tag.dart";
import "package:hollyday_land_dao/filter_dao.dart";

part "suitability.objects.filter_tags.dart";

@FilterTagDao("trail_suitabilities")
class TrailSuitability with FilterTag {
  @override
  final int id;
  @override
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
}
