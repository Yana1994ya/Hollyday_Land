import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land/models/filter_tag.dart";
import "package:hollyday_land_dao/filter_dao.dart";

part "region.objects.filter_tags.dart";

@FilterTagDao("regions")
class Region with FilterTag {
  @override
  final int id;
  @override
  final String name;

  Region({
    required this.id,
    required this.name,
  });

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      id: json["id"],
      name: json["name"],
    );
  }

  @override
  String toString() {
    return "Region{id: $id, name: $name}";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Region &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
