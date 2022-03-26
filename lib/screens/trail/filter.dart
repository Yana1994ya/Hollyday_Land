import "package:flutter/material.dart";
import "package:hollyday_land/models/trail/activity.dart";
import "package:hollyday_land/models/trail/attraction.dart";
import "package:hollyday_land/models/trail/filter.dart";
import "package:hollyday_land/models/trail/suitability.dart";
import "package:hollyday_land/models/trail/tags.dart";
import "package:hollyday_land/widgets/filter/chips.dart";
import "package:hollyday_land/widgets/filter/difficulty_chips.dart";

const maxDistance = 150 * 1000;
const minDistance = 1 * 1000;
const maxElevationGain = 4000;
const minElevationGain = 100;

class TrailsFilterScreen extends StatelessWidget {
  final TrailsFilter initialFilter;

  const TrailsFilterScreen({
    Key? key,
    required this.initialFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TrailTags>(
      future: TrailTags.retrieve(),
      builder: (_cnt, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text("Trails filter")),
            body: Center(child: Text("error: ${snapshot.error}")),
          );
        } else if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(title: const Text("Trails filter")),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else {
          return LoadedTrailsFilterScreen(
            initialFilter: initialFilter,
            tags: snapshot.data!,
          );
        }
      },
    );
  }
}

class LoadedTrailsFilterScreen extends StatefulWidget {
  final TrailsFilter initialFilter;
  final TrailTags tags;

  const LoadedTrailsFilterScreen({
    Key? key,
    required this.initialFilter,
    required this.tags,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoadedTrailsFilterScreenState();
}

class _LoadedTrailsFilterScreenState extends State<LoadedTrailsFilterScreen> {
  late TrailsFilter filter;

  @override
  void initState() {
    filter = widget.initialFilter;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final titleTheme = Theme.of(context).textTheme.headline6;

    return Scaffold(
      appBar: AppBar(
        title: Text("Trails filter"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(filter);
            },
            child: const Text(
              "Save",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Text(
              "Trail length - Minimum",
              style: titleTheme,
            ),
            Slider(
              value: filter.length.rangeStart == null
                  ? 0.0
                  : filter.length.rangeStart!.toDouble(),
              min: 0,
              max: maxDistance.toDouble(),
              divisions: 100,
              onChanged: (newValue) {
                setState(() {
                  final MeterRange newLength;

                  if (newValue == 0.0) {
                    newLength = filter.length.copyWith.rangeStart(null);
                  } else {
                    newLength =
                        filter.length.copyWith.rangeStart(newValue.toInt());
                  }

                  filter = filter.copyWith(length: newLength);
                });
              },
              label: filter.length.rangeStart == null
                  ? "Any"
                  : (filter.length.rangeStart! / 1000).toString() + "km",
            ),
            Divider(),
            Text(
              "Trail length - Maximum",
              style: titleTheme,
            ),
            Slider(
              value: filter.length.rangeEnd == null
                  ? maxDistance.toDouble()
                  : filter.length.rangeEnd!.toDouble(),
              min: minDistance.toDouble(),
              max: (maxDistance + minDistance).toDouble(),
              divisions: 100,
              onChanged: (newValue) {
                setState(() {
                  final MeterRange newLength;

                  if (newValue == maxDistance) {
                    newLength = filter.length.copyWith.rangeEnd(null);
                  } else {
                    newLength =
                        filter.length.copyWith.rangeEnd(newValue.toInt());
                  }

                  filter = filter.copyWith(length: newLength);
                });
              },
              label: filter.length.rangeEnd == null
                  ? "Any"
                  : (filter.length.rangeEnd! / 1000).toString() + "km",
            ),
            Divider(),
            Text(
              "Elevation gain - Minimum",
              style: titleTheme,
            ),
            Slider(
              value: filter.elevationGain.rangeStart == null
                  ? 0.0
                  : filter.elevationGain.rangeStart!.toDouble(),
              min: 0,
              max: maxElevationGain.toDouble(),
              divisions: 80,
              onChanged: (newValue) {
                setState(() {
                  final MeterRange newRange;

                  if (newValue == 0.0) {
                    newRange = filter.elevationGain.copyWith.rangeStart(null);
                  } else {
                    newRange = filter.elevationGain.copyWith
                        .rangeStart(newValue.toInt());
                  }

                  filter = filter.copyWith(elevationGain: newRange);
                });
              },
              label: filter.elevationGain.rangeStart == null
                  ? "Any"
                  : (filter.elevationGain.rangeStart!).toString() + "m",
            ),
            Divider(),
            Text(
              "Elevation gain - Maximum",
              style: titleTheme,
            ),
            Slider(
              value: filter.elevationGain.rangeEnd == null
                  ? (maxElevationGain + minElevationGain).toDouble()
                  : filter.elevationGain.rangeEnd!.toDouble(),
              min: minElevationGain.toDouble(),
              max: (maxElevationGain + minElevationGain).toDouble(),
              divisions: 80,
              onChanged: (newValue) {
                setState(() {
                  final MeterRange newRange;
                  if (newValue == 4000) {
                    newRange = filter.elevationGain.copyWith.rangeEnd(null);
                  } else {
                    newRange = filter.elevationGain.copyWith
                        .rangeEnd(newValue.toInt());
                  }

                  filter = filter.copyWith(elevationGain: newRange);
                });
              },
              label: filter.elevationGain.rangeEnd == null
                  ? "Any"
                  : (filter.elevationGain.rangeEnd!).toString() + "m",
            ),
            Divider(),
            Text(
              "Difficulty",
              style: titleTheme,
            ),
            DifficultyFilterChips(
              initialSelected: filter.difficulty,
              onChange: (newDifficulties) {
                filter = filter.copyWith(difficulty: newDifficulties);
              },
            ),
            Divider(),
            Text(
              "Activities",
              style: titleTheme,
            ),
            FilterChips<TrailActivity>(
              items: widget.tags.activities,
              initialSelected: filter.activities,
              onChange: (newActivities) {
                filter = filter.copyWith(activities: newActivities);
              },
            ),
            Divider(),
            Text(
              "Attractions",
              style: titleTheme,
            ),
            FilterChips<TrailAttraction>(
              items: widget.tags.attractions,
              initialSelected: filter.attractions,
              onChange: (newAttractions) {
                filter = filter.copyWith(attractions: newAttractions);
              },
            ),
            Divider(),
            Text(
              "Suitability",
              style: titleTheme,
            ),
            FilterChips<TrailSuitability>(
              items: widget.tags.suitabilities,
              initialSelected: filter.suitabilities,
              onChange: (newSuitabilities) {
                filter = filter.copyWith(suitabilities: newSuitabilities);
              },
            ),
          ],
        ),
      ),
    );
  }
}
