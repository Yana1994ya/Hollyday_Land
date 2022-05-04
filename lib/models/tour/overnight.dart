import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land/models/filter_tag.dart";
import "package:hollyday_land/models/image_asset.dart";
import "package:hollyday_land_dao/filter_dao.dart";

part "overnight.objects.filter_tags.dart";

@FilterTagDao("overnights")
class Overnight with FilterTag {
  @override
  final int id;
  @override
  final String name;

  final ImageAsset? image;

  const Overnight({required this.id, required this.name, required this.image});

  factory Overnight.fromJson(Map<String, dynamic> json) {
    return Overnight(
        id: json["id"],
        name: json["name"],
        image:
            json["image"] == null ? null : ImageAsset.fromJson(json["image"]));
  }

  @override
  String toString() {
    return "Overnight{id: $id, name: $name, image: $image}";
  }
}
