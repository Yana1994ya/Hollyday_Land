import "package:hollyday_land/models/dao/base_attraction.dart";
import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land/models/extreme_sports/types.dart";
import "package:hollyday_land_dao/full_dao.dart";

part "item.objects.full.dart";

@FullDao("extreme_sports")
class ExtremeSports extends ManagedAttraction {
  final ExtremeSportsType sportsType;

  const ExtremeSports({
    required BaseAttraction base,
    required this.sportsType,
  }) : super(base);

  factory ExtremeSports.fromJson(Map<String, dynamic> json) {
    return ExtremeSports(
      base: BaseAttraction.fromJson(json),
      sportsType: ExtremeSportsType.fromJson(json["attraction_type"]),
    );
  }

  @override
  String toString() {
    return genString("ExtremeSports", "sportsType:$sportsType");
  }
}
