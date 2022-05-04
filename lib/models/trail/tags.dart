import "package:hollyday_land/models/trail/activity.dart";
import "package:hollyday_land/models/trail/attraction.dart";
import "package:hollyday_land/models/trail/suitability.dart";

class TrailTags {
  final List<TrailSuitability> suitabilities;
  final List<TrailActivity> activities;
  final List<TrailAttraction> attractions;

  const TrailTags({
    required this.suitabilities,
    required this.activities,
    required this.attractions,
  });

  static Future<TrailTags> retrieve() async {
    // Read suitabilities, activities and attractions at the same time
    final results = await Future.wait([
      trailSuitabilityObjects.readTags(),
      trailActivityObjects.readTags(),
      trailAttractionObjects.readTags(),
    ]);

    // Awaiting above ensures all 3 filter tags are loaded, and
    // can be found in the index co-responding to thier index in the list
    // passed to Future.wait

    // Future.wait returns List<dynamic> because we are reading different things, so cast back to the
    // correct type
    return TrailTags(
      suitabilities: results[0] as List<TrailSuitability>,
      activities: results[1] as List<TrailActivity>,
      attractions: results[2] as List<TrailAttraction>,
    );
  }
}
