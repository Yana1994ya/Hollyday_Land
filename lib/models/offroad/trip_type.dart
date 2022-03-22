import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land/models/filter_tag.dart";
import "package:hollyday_land_dao/filter_dao.dart";

part "trip_type.objects.filter_tags.dart";

@FilterTagDao("off_road_trip_types")
class OffRoadTripType with FilterTag {
  @override
  final int id;
  @override
  final String name;

  OffRoadTripType({required this.id, required this.name});

  factory OffRoadTripType.fromJson(Map<String, dynamic> json) {
    return OffRoadTripType(
      id: json["id"],
      name: json["name"],
    );
  }

  @override
  String toString() {
    return "OffroadTripType{id: $id, name: $name}";
  }
}
