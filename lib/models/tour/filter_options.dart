import "package:hollyday_land/models/tour/destination.dart";
import "package:hollyday_land/models/tour/package.dart";
import "package:hollyday_land/models/tour/tour_language.dart";

class TourFilterOptions {
  final List<Package> package;
  final List<TourLanguage> tourLanguage;
  final List<TourDestination> tourDestination;

  const TourFilterOptions({
    required this.package,
    required this.tourLanguage,
    required this.tourDestination,
  });

  static Future<TourFilterOptions> retrieve() async {
    // Read all the tags
    final results = await Future.wait([
      packageObjects.readTags(),
      tourLanguageObjects.readTags(),
      tourDestinationObjects.readTags(),
    ]);

    return TourFilterOptions(
      package: results[0] as List<Package>,
      tourLanguage: results[1] as List<TourLanguage>,
      tourDestination: results[2] as List<TourDestination>,
    );
  }
}
