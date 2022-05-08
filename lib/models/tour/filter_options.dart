import 'package:hollyday_land/models/tour/overnight.dart';
import 'package:hollyday_land/models/tour/package.dart';
import 'package:hollyday_land/models/tour/tour_destination.dart';
import 'package:hollyday_land/models/tour/tour_language.dart';
import 'package:hollyday_land/models/tour/tour_theme.dart';
import 'package:hollyday_land/models/tour/tour_type.dart';

class TourFilterOptions {
  final List<Overnight> overnight;
  final List<Package> package;
  final List<TourDestination> tourDestination;
  final List<TourLanguage> tourLanguage;
  final List<TourTheme> tourTheme;
  final List<TourType> tourType;

  const TourFilterOptions({
    required this.overnight,
    required this.package,
    required this.tourDestination,
    required this.tourLanguage,
    required this.tourTheme,
    required this.tourType,
  });

  static Future<TourFilterOptions> retrieve() async {
    // Read all the tags
    final results = await Future.wait([
      overnightObjects.readTags(),
      packageObjects.readTags(),
      tourDestinationObjects.readTags(),
      tourLanguageObjects.readTags(),
      tourThemeObjects.readTags(),
      tourTypeObjects.readTags(),
    ]);

    return TourFilterOptions(
      overnight: results[0] as List<Overnight>,
      package: results[1] as List<Package>,
      tourDestination: results[2] as List<TourDestination>,
      tourLanguage: results[3] as List<TourLanguage>,
      tourTheme: results[4] as List<TourTheme>,
      tourType: results[5] as List<TourType>,
    );
  }
}
