import "package:hollyday_land/models/zoo/short.dart";
import "package:hollyday_land/screens/user_attractions.dart";
import "package:hollyday_land/widgets/list_item.dart";
import "package:hollyday_land/widgets/zoo/list_item.dart";

class FavoritesZoosScreen extends UserAttractionsScreen<ZooShort> {
  static const routePath = "/favorites/zoos";

  @override
  AttractionListItem<ZooShort> getListItem(ZooShort attraction) {
    return ZooListItem(zoo: attraction);
  }

  @override
  String itemCountText(List<ZooShort> attractions) {
    return "favorite ${attractions.length} zoos";
  }

  @override
  Future<List<ZooShort>> readHistory(String hdToken) {
    return ZooShort.readFavorites(hdToken);
  }

  @override
  String get pageTitle => "Favorite zoos";
}
