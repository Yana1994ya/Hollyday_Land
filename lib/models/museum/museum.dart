import "package:hollyday_land/models/dao/base_attraction.dart";
import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land/models/museum/museum_domain.dart";
import "package:hollyday_land_dao/full_dao.dart";

part "museum.objects.full.dart";

@FullDao("museums", "museum")
class Museum extends ManagedAttraction {
  final MuseumDomain domain;

  const Museum({
    required BaseAttraction base,
    required this.domain,
  }) : super(base);

  factory Museum.fromJson(Map<String, dynamic> json) {
    return Museum(
      base: BaseAttraction.fromJson(json),
      domain: MuseumDomain.fromJson(json["domain"]),
    );
  }

  @override
  String toString() {
    return genString("Museum", "domain:$domain");
  }
}
