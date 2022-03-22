import "package:hollyday_land/models/dao/base_attraction.dart";
import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land_dao/full_dao.dart";

part "zoo.objects.full.dart";

@FullDao("zoos", "zoo")
class Zoo extends ManagedAttraction {
  Zoo({
    required BaseAttraction base,
  }) : super(base);

  factory Zoo.fromJson(Map<String, dynamic> json) {
    return Zoo(
      base: BaseAttraction.fromJson(json),
    );
  }

  @override
  String toString() => genString("Zoo");
}
