import "package:hollyday_land/models/dao/base_attraction_short.dart";
import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land_dao/list_dao.dart";

part "short.objects.list.dart";

@ListDao("hot_air")
class HotAirShort extends ManagedAttractionShort {
  HotAirShort({required BaseAttractionShort base}) : super(base);

  factory HotAirShort.fromJson(Map<String, dynamic> json) {
    return HotAirShort(
      base: BaseAttractionShort.fromJson(json),
    );
  }

  @override
  String toString() => genString("HotAirShort");
}
