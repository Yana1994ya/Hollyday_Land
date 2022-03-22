import "package:hollyday_land/models/dao/base_attraction.dart";
import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land/models/rock_climbing/attraction_type.dart";
import "package:hollyday_land_dao/full_dao.dart";

part "item.objects.full.dart";

@FullDao("rock_climbing")
class RockClimbingItem extends ManagedAttraction {
  final RockClimbingAttractionType attractionType;

  RockClimbingItem({
    required BaseAttraction base,
    required this.attractionType,
  }) : super(base);

  factory RockClimbingItem.fromJson(Map<String, dynamic> json) {
    return RockClimbingItem(
      base: BaseAttraction.fromJson(json),
      attractionType:
          RockClimbingAttractionType.fromJson(json["attraction_type"]),
    );
  }

  @override
  String toString() => genString(
        "RockClimbingItem",
        "attractionType: $attractionType",
      );
}
