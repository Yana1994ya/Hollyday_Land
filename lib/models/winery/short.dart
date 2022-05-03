import "package:hollyday_land/models/dao/base_attraction_short.dart";
import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land_dao/list_dao.dart";

part "short.objects.list.dart";

@ListDao("wineries")
class WineryShort extends ManagedAttractionShort {
  WineryShort({required BaseAttractionShort base}) : super(base);

  factory WineryShort.fromJson(Map<String, dynamic> json) {
    return WineryShort(
      base: BaseAttractionShort.fromJson(json),
    );
  }

  @override
  String toString() => genString("WineryShort");
}
