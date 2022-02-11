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
    final results = await Future.wait([
      TrailSuitability.readSuitabilities(),
      TrailActivity.readActivities(),
      TrailAttraction.readAttractions(),
    ]);

    return TrailTags(
      suitabilities: results[0] as List<TrailSuitability>,
      activities: results[1] as List<TrailActivity>,
      attractions: results[2] as List<TrailAttraction>,
    );
  }
}
