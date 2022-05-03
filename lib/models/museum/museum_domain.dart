import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land/models/filter_tag.dart";
import "package:hollyday_land_dao/filter_dao.dart";

part "museum_domain.objects.filter_tags.dart";

@FilterTagDao("museum_domains")
class MuseumDomain with FilterTag {
  @override
  final int id;
  @override
  final String name;

  const MuseumDomain({required this.id, required this.name});

  factory MuseumDomain.fromJson(Map<String, dynamic> json) {
    return MuseumDomain(
      id: json["id"],
      name: json["name"],
    );
  }

  @override
  String toString() {
    return "MuseumDomain{id: $id, name: $name}";
  }
}
