import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land/models/filter_tag.dart";
import "package:hollyday_land_dao/filter_dao.dart";

part "tour_destination.objects.filter_tags.dart";

@FilterTagDao("tour_destinations")
class TourDestination with FilterTag {
  @override
  final int id;
  @override
  final String name;

  const TourDestination({required this.id, required this.name});

  factory TourDestination.fromJson(Map<String, dynamic> json) {
    return TourDestination(id: json["id"], name: json["name"]);
  }

  @override
  String toString() {
    return "TourDestination{id: $id, name: $name}";
  }
}
