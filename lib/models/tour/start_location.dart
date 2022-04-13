import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land/models/filter_tag.dart";
import "package:hollyday_land_dao/filter_dao.dart";

part "start_location.objects.filter_tags.dart";

@FilterTagDao("start_locations")
class StartLocation with FilterTag {
  @override
  final int id;
  @override
  final String name;

  const StartLocation({required this.id, required this.name});

  factory StartLocation.fromJson(Map<String, dynamic> json) {
    return StartLocation(id: json["id"], name: json["name"]);
  }

  @override
  String toString() {
    return "StartLocation{id: $id, name: $name}";
  }
}
