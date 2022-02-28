import "package:built_collection/built_collection.dart";
import "package:copy_with_extension/copy_with_extension.dart";
import "package:hollyday_land/models/trail/difficulty.dart";

part "filter.g.dart";

@CopyWith()
class MeterRange {
  final int? rangeStart;
  final int? rangeEnd;

  MeterRange({this.rangeStart, this.rangeEnd});

  void _addParameter(Map<String, Iterable<String>> params, String prefix) {
    if (rangeStart != null) {
      params["${prefix}_start"] = [rangeStart.toString()];
    }

    if (rangeEnd != null) {
      params["${prefix}_end"] = [rangeEnd.toString()];
    }
  }
}

@CopyWith()
class TrailsFilter {
  final BuiltSet<Difficulty> difficulty;
  final BuiltSet<int> activities;
  final BuiltSet<int> attractions;
  final BuiltSet<int> suitabilities;
  final MeterRange length;
  final MeterRange elevationGain;

  TrailsFilter({
    required this.difficulty,
    required this.length,
    required this.elevationGain,
    required this.activities,
    required this.attractions,
    required this.suitabilities,
  });

  factory TrailsFilter.empty() {
    return TrailsFilter(
      difficulty: BuiltSet.of([]),
      length: MeterRange(),
      elevationGain: MeterRange(),
      activities: BuiltSet.of([]),
      attractions: BuiltSet.of([]),
      suitabilities: BuiltSet.of([]),
    );
  }

  Map<String, Iterable<String>> parameters(int cache) {
    final Map<String, Iterable<String>> params = {};

    if (difficulty.isNotEmpty) {
      params["difficulty"] = difficulty.map(difficultyToString);
    }

    length._addParameter(params, "length");
    elevationGain._addParameter(params, "elevation_gain");

    if (activities.isNotEmpty) {
      params["activities"] = activities.map((id) => id.toString());
    }

    if (attractions.isNotEmpty) {
      params["attractions"] = attractions.map((id) => id.toString());
    }

    if (suitabilities.isNotEmpty) {
      params["suitabilities"] = suitabilities.map((id) => id.toString());
    }

    params["cache"] = [cache.toString()];

    return params;
  }
}
