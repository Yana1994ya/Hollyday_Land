import "package:hollyday_land/models/dao/base_attraction_short.dart";
import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land/models/extreme_sports/types.dart";
import "package:hollyday_land_dao/list_dao.dart";

part "short.objects.list.dart";

@ListDao("extreme_sports")
class ExtremeSportsShort extends ManagedAttractionShort {
  final ExtremeSportsType sportsType;

  const ExtremeSportsShort({
    required BaseAttractionShort base,
    required this.sportsType,
  }) : super(base);

  factory ExtremeSportsShort.fromJson(Map<String, dynamic> json) {
    return ExtremeSportsShort(
      base: BaseAttractionShort.fromJson(json),
      sportsType: ExtremeSportsType.fromJson(json["attraction_type"]),
    );
  }

  @override
  String toString() {
    return genString("ExtremeSportsShort", "sportsType:$sportsType");
  }
}
