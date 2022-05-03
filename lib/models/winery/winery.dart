import "package:hollyday_land/models/dao/base_attraction.dart";
import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land_dao/full_dao.dart";

part "winery.objects.full.dart";

@FullDao("wineries", "winery")
class Winery extends ManagedAttraction {
  Winery({required BaseAttraction base}) : super(base);

  factory Winery.fromJson(Map<String, dynamic> json) {
    return Winery(
      base: BaseAttraction.fromJson(json),
    );
  }

  @override
  String toString() => genString("Winery");
}
