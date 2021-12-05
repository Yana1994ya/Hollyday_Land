import "package:hollyday_land/models/offroad/short.dart";
import "package:hollyday_land/screens/user_attractions.dart";
import "package:hollyday_land/widgets/list_item.dart";
import "package:hollyday_land/widgets/offroad/list_item.dart";

class FavoritesOffRoadTripsScreen
    extends UserAttractionsScreen<OffRoadTripShort> {
  static const routePath = "/favorites/off_road_trips";

  @override
  AttractionListItem<OffRoadTripShort> getListItem(
      OffRoadTripShort attraction) {
    return OffRoadTripListItem(trip: attraction);
  }

  @override
  String itemCountText(List<OffRoadTripShort> attractions) {
    return "favorite ${attractions.length} off road trips";
  }

  @override
  Future<List<OffRoadTripShort>> readAttractions(String hdToken) {
    return OffRoadTripShort.readFavorites(hdToken);
  }

  @override
  String get pageTitle => "Favorite Off Road trips";
}
