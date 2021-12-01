import "package:hollyday_land/models/winery/short.dart";
import "package:hollyday_land/screens/user_attractions.dart";
import "package:hollyday_land/widgets/list_item.dart";
import "package:hollyday_land/widgets/winery/list_item.dart";

class HistoryWineriesScreen extends UserAttractionsScreen<WineryShort> {
  static const routePath = "/history/wineries";

  @override
  AttractionListItem<WineryShort> getListItem(WineryShort attraction) {
    return WineryListItem(winery: attraction);
  }

  @override
  String itemCountText(List<WineryShort> attractions) {
    return "found ${attractions.length} wineries";
  }

  @override
  String get pageTitle => "Visited wineries";

  @override
  Future<List<WineryShort>> readAttractions(String hdToken) {
    return WineryShort.readHistory(hdToken);
  }
}
