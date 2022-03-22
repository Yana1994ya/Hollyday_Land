import 'package:hollyday_land/models/dao/model_access.dart';
import "package:hollyday_land/models/filter_tag.dart";
import 'package:hollyday_land_dao/filter_dao.dart';

part "attraction.objects.filter_tags.dart";

@FilterTagDao("trail_attractions")
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
}
