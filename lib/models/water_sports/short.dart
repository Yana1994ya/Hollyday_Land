import "package:hollyday_land/models/dao/base_attraction_short.dart";
import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land/models/water_sports/attraction_type.dart";
import "package:hollyday_land_dao/list_dao.dart";

part "short.objects.list.dart";

@ListDao("water_sports")
class WaterSportsShort extends ManagedAttractionShort {
  final WaterSportsAttractionType attractionType;

  WaterSportsShort({
    required BaseAttractionShort base,
    required this.attractionType,
  }) : super(base);

  factory WaterSportsShort.fromJson(Map<String, dynamic> json) {
    return WaterSportsShort(
      base: BaseAttractionShort.fromJson(json),
      attractionType:
          WaterSportsAttractionType.fromJson(json["attraction_type"]),
    );
  }

  @override
  String toString() =>
      genString("WaterSportsShort", "attractionType: $attractionType");
}
