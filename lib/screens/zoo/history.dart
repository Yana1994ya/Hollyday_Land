import "package:hollyday_land/models/zoo/short.dart";
import "package:hollyday_land/screens/user_attractions.dart";
import "package:hollyday_land/widgets/list_item.dart";
import "package:hollyday_land/widgets/zoo/list_item.dart";

class HistoryZoosScreen extends UserAttractionsScreen<ZooShort> {
  static const routePath = "/history/zoos";

  @override
  AttractionListItem<ZooShort> getListItem(ZooShort attraction) {
    return ZooListItem(zoo: attraction);
  }

  @override
  String itemCountText(List<ZooShort> attractions) {
    return "found ${attractions.length} zoos";
  }

  @override
  String get pageTitle => "Visited zoos";

  @override
  Future<List<ZooShort>> readHistory(String hdToken) {
    return ZooShort.readHistory(hdToken);
  }
}
