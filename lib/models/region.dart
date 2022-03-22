import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land/models/filter_tag.dart";
import "package:hollyday_land/models/image_asset.dart";
import "package:hollyday_land_dao/filter_dao.dart";

part "region.objects.filter_tags.dart";

@FilterTagDao("regions")
class Region with FilterTag {
  @override
  final int id;
  @override
  final String name;
  final ImageAsset? image;

  Region({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      id: json["id"],
      name: json["name"],
      image: json["image"] == null ? null : ImageAsset.fromJson(json["image"]),
    );
  }

  @override
  String toString() {
    return "Region{id: $id, name: $name, image: $image}";
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Region &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              image == other.image;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ image.hashCode;
}
