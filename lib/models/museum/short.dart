import "package:hollyday_land/models/dao/base_attraction_short.dart";
import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land/models/museum/museum_domain.dart";
import "package:hollyday_land_dao/list_dao.dart";

part "short.objects.list.dart";

@ListDao("museums")
class MuseumShort extends ManagedAttractionShort {
  final MuseumDomain domain;

  const MuseumShort({
    required BaseAttractionShort base,
    required this.domain,
  }) : super(base);

  factory MuseumShort.fromJson(Map<String, dynamic> json) {
    return MuseumShort(
      base: BaseAttractionShort.fromJson(json),
      domain: MuseumDomain.fromJson(json["domain"]),
    );
  }

  @override
  String toString() {
    return genString("MuseumShort", "domain: $domain");
  }
}
