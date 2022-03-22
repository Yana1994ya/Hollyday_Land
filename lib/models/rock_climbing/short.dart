import "package:hollyday_land/models/dao/base_attraction_short.dart";
import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land/models/rock_climbing/attraction_type.dart";
import "package:hollyday_land_dao/list_dao.dart";

part "short.objects.list.dart";

@ListDao("rock_climbing")
class RockClimbingShort extends ManagedAttractionShort {
  final RockClimbingAttractionType attractionType;

  RockClimbingShort({
    required BaseAttractionShort base,
    required this.attractionType,
  }) : super(base);

  factory RockClimbingShort.fromJson(Map<String, dynamic> json) {
    return RockClimbingShort(
      base: BaseAttractionShort.fromJson(json),
      attractionType:
          RockClimbingAttractionType.fromJson(json["attraction_type"]),
    );
  }

  @override
  String toString() => genString(
        "RockClimbingShort",
        "attractionType: $attractionType",
      );
}
