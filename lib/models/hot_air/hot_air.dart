import "package:hollyday_land/models/dao/base_attraction.dart";
import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land_dao/full_dao.dart";

part "hot_air.objects.full.dart";

@FullDao("hot_air")
class HotAir extends ManagedAttraction {
  HotAir({
    required BaseAttraction base,
  }) : super(base);

  factory HotAir.fromJson(Map<String, dynamic> json) {
    return HotAir(
      base: BaseAttraction.fromJson(json),
    );
  }

  @override
  String toString() => genString("HotAir");
}
