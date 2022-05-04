import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land/models/filter_tag.dart";
import "package:hollyday_land_dao/filter_dao.dart";

part "tour_language.objects.filter_tags.dart";

@FilterTagDao("tour_languages")
class TourLanguage with FilterTag {
  @override
  final int id;
  @override
  final String name;

  const TourLanguage({required this.id, required this.name});

  factory TourLanguage.fromJson(Map<String, dynamic> json) {
    return TourLanguage(id: json["id"], name: json["name"]);
  }

  @override
  String toString() {
    return "TourLanguage{id: $id, name: $name}";
  }
}
