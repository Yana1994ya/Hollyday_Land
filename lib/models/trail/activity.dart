import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land/models/filter_tag.dart";
import "package:hollyday_land_dao/filter_dao.dart";

part "activity.objects.filter_tags.dart";

@FilterTagDao("trail_activities")
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
}
