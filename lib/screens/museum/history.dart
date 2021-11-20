import "package:hollyday_land/models/museum/short.dart";
import "package:hollyday_land/screens/user_attractions.dart";
import "package:hollyday_land/widgets/list_item.dart";
import "package:hollyday_land/widgets/museum/list_item.dart";

class HistoryMuseumsScreen extends UserAttractionsScreen<MuseumShort> {
  static const routePath = "/history/museums";

  @override
  AttractionListItem<MuseumShort> getListItem(MuseumShort attraction) {
    return MuseumListItem(museum: attraction);
  }

  @override
  String itemCountText(List<MuseumShort> attractions) {
    return "found ${attractions.length} museums";
  }

  @override
  String get pageTitle => "Visited museums";

  @override
  Future<List<MuseumShort>> readHistory(String hdToken) {
    return MuseumShort.readHistory(hdToken);
  }
}
