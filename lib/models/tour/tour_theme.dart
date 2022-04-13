import "package:hollyday_land/models/dao/model_access.dart";
import "package:hollyday_land/models/filter_tag.dart";
import "package:hollyday_land/models/image_asset.dart";
import "package:hollyday_land_dao/filter_dao.dart";

part "tour_theme.objects.filter_tags.dart";

@FilterTagDao("tour_themes")
class TourTheme with FilterTag {
  @override
  final int id;
  @override
  final String name;

  final ImageAsset? image;
  final bool focus;

  const TourTheme({
    required this.id,
    required this.name,
    required this.image,
    required this.focus,
  });

  factory TourTheme.fromJson(Map<String, dynamic> json) {
    return TourTheme(
      id: json["id"],
      name: json["name"],
      image: json["image"] == null ? null : ImageAsset.fromJson(json["image"]),
      focus: json["focus"],
    );
  }

  @override
  String toString() {
    return "TourTheme{id: $id, name: $name, image: $image, focus: $focus}";
  }
}
