import "package:hollyday_land/models/dao/base_attraction.dart";
import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land/models/water_sports/attraction_type.dart";
import "package:hollyday_land_dao/full_dao.dart";

part "item.objects.full.dart";

@FullDao("water_sports")
class WaterSportsItem extends ManagedAttraction {
  final WaterSportsAttractionType attractionType;

  WaterSportsItem({
    required BaseAttraction base,
    required this.attractionType,
  }) : super(base);

  factory WaterSportsItem.fromJson(Map<String, dynamic> json) {
    return WaterSportsItem(
      base: BaseAttraction.fromJson(json),
      attractionType:
          WaterSportsAttractionType.fromJson(json["attraction_type"]),
    );
  }

  @override
  String toString() =>
      genString("WaterSportsItem", "attractionType: $attractionType");
}
