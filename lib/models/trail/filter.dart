import "package:hollyday_land/models/trail/difficulty.dart";

class MeterRange {
  final int rangeStart;
  final int rangeEnd;

  MeterRange(this.rangeStart, this.rangeEnd);

  void _addParameter(Map<String, Iterable<String>> params, String prefix) {
    params["${prefix}_start"] = [rangeStart.toString()];
    params["${prefix}_end"] = [rangeEnd.toString()];
  }
}

class TrailsFilter {
  final Set<Difficulty> difficulty;
  final MeterRange? length;
  final MeterRange? elevationGain;

  TrailsFilter({
    required this.difficulty,
    required this.length,
    required this.elevationGain,
  });

  factory TrailsFilter.empty() {
    return TrailsFilter(
      difficulty: {},
      length: null,
      elevationGain: null,
    );
  }

  Map<String, Iterable<String>> parameters(int cache) {
    final Map<String, Iterable<String>> params = {};

    if (difficulty.isNotEmpty) {
      params["difficulty"] = difficulty.map(difficultyToString);
    }

    // The ?. operator does operation if not null(otherwise returns null,
    // but return value is ignored so it basically does nothing)
    length?._addParameter(params, "length");
    elevationGain?._addParameter(params, "elevation_gain");

    params["cache"] = [cache.toString()];

    return params;
  }
}
