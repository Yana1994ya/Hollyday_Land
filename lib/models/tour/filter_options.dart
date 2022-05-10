import "package:hollyday_land/models/tour/package.dart";
import "package:hollyday_land/models/tour/tour_language.dart";
import "package:hollyday_land/models/tour/tour_theme.dart";
import "package:hollyday_land/models/tour/tour_type.dart";

class TourFilterOptions {
  final List<Package> package;
  final List<TourLanguage> tourLanguage;
  final List<TourTheme> tourTheme;
  final List<TourType> tourType;

  const TourFilterOptions({
    required this.package,
    required this.tourLanguage,
    required this.tourTheme,
    required this.tourType,
  });

  static Future<TourFilterOptions> retrieve() async {
    // Read all the tags
    final results = await Future.wait([
      packageObjects.readTags(),
      tourLanguageObjects.readTags(),
      tourThemeObjects.readTags(),
      tourTypeObjects.readTags(),
    ]);

    return TourFilterOptions(
      package: results[0] as List<Package>,
      tourLanguage: results[1] as List<TourLanguage>,
      tourTheme: results[2] as List<TourTheme>,
      tourType: results[3] as List<TourType>,
    );
  }
}
