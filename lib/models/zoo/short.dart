import "package:hollyday_land/models/dao/base_attraction_short.dart";
import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land_dao/list_dao.dart";

part "short.objects.list.dart";

@ListDao("zoos")
class ZooShort extends ManagedAttractionShort {
  ZooShort({required BaseAttractionShort base}) : super(base);

  factory ZooShort.fromJson(Map<String, dynamic> json) {
    return ZooShort(
      base: BaseAttractionShort.fromJson(json),
    );
  }

  @override
  String toString() => genString("ZooShort");
}
