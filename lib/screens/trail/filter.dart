import "package:flutter/material.dart";
import "package:hollyday_land/models/trail/difficulty.dart";
import "package:hollyday_land/models/trail/filter.dart";
import "package:hollyday_land/widgets/filter/chips.dart";

const maxDistance = 150 * 1000;
const minDistance = 1 * 1000;
const maxElevationGain = 4000;
const minElevationGain = 100;

class TrailsFilterScreen extends StatefulWidget {
  final TrailsFilter initialFilter;

  const TrailsFilterScreen({Key? key, required this.initialFilter})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TrailsFilterScreenState();
}

class _TrailsFilterScreenState extends State<TrailsFilterScreen> {
  MeterRange lengthRange = MeterRange(null, null);
  MeterRange elvGainRange = MeterRange(null, null);
  Set<Difficulty> difficulty = {};

  @override
  void initState() {
    if (widget.initialFilter.length != null) {
      lengthRange = widget.initialFilter.length!;
    }

    if (widget.initialFilter.elevationGain != null) {
      elvGainRange = widget.initialFilter.elevationGain!;
    }

    difficulty = widget.initialFilter.difficulty;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final titleTheme = Theme.of(context).textTheme.headline6;

    return Scaffold(
      appBar: AppBar(
        title: Text("Trails filter"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop(TrailsFilter(
                difficulty: difficulty,
                length: lengthRange,
                elevationGain: elvGainRange,
              ));
            },
            icon: Icon(Icons.save),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop(TrailsFilter.empty());
            },
            icon: Icon(Icons.delete),
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
              value: lengthRange.rangeStart == null
                  ? 0.0
                  : lengthRange.rangeStart!.toDouble(),
              min: 0,
              max: maxDistance.toDouble(),
              divisions: 100,
              onChanged: (newValue) {
                setState(() {
                  if (newValue == 0.0) {
                    lengthRange = MeterRange(null, lengthRange.rangeEnd);
                  } else {
                    lengthRange =
                        MeterRange(newValue.toInt(), lengthRange.rangeEnd);
                  }
                });
              },
              label: lengthRange.rangeStart == null
                  ? "Any"
                  : (lengthRange.rangeStart! / 1000).toString() + "km",
            ),
            Divider(),
            Text(
              "Trail length - Maximum",
              style: titleTheme,
            ),
            Slider(
              value: lengthRange.rangeEnd == null
                  ? maxDistance.toDouble()
                  : lengthRange.rangeEnd!.toDouble(),
              min: minDistance.toDouble(),
              max: (maxDistance + minDistance).toDouble(),
              divisions: 100,
              onChanged: (newValue) {
                setState(() {
                  if (newValue == maxDistance) {
                    lengthRange = MeterRange(lengthRange.rangeStart, null);
                  } else {
                    lengthRange =
                        MeterRange(lengthRange.rangeStart, newValue.toInt());
                  }
                });
              },
              label: lengthRange.rangeEnd == null
                  ? "Any"
                  : (lengthRange.rangeEnd! / 1000).toString() + "km",
            ),
            Divider(),
            Text(
              "Elevation gain - Minimum",
              style: titleTheme,
            ),
            Slider(
              value: elvGainRange.rangeStart == null
                  ? 0.0
                  : elvGainRange.rangeStart!.toDouble(),
              min: 0,
              max: maxElevationGain.toDouble(),
              divisions: 80,
              onChanged: (newValue) {
                setState(() {
                  if (newValue == 0.0) {
                    elvGainRange = MeterRange(null, elvGainRange.rangeEnd);
                  } else {
                    elvGainRange =
                        MeterRange(newValue.toInt(), elvGainRange.rangeEnd);
                  }
                });
              },
              label: elvGainRange.rangeStart == null
                  ? "Any"
                  : (elvGainRange.rangeStart!).toString() + "m",
            ),
            Divider(),
            Text(
              "Elevation gain - Maximum",
              style: titleTheme,
            ),
            Slider(
              value: elvGainRange.rangeEnd == null
                  ? (maxElevationGain + minElevationGain).toDouble()
                  : elvGainRange.rangeEnd!.toDouble(),
              min: minElevationGain.toDouble(),
              max: (maxElevationGain + minElevationGain).toDouble(),
              divisions: 80,
              onChanged: (newValue) {
                setState(() {
                  if (newValue == 4000) {
                    elvGainRange = MeterRange(elvGainRange.rangeStart, null);
                  } else {
                    elvGainRange =
                        MeterRange(elvGainRange.rangeStart, newValue.toInt());
                  }
                });
              },
              label: elvGainRange.rangeEnd == null
                  ? "Any"
                  : (elvGainRange.rangeEnd!).toString() + "m",
            ),
            Divider(),
            Text(
              "Difficulty",
              style: titleTheme,
            ),
            FilterChips.choiceChips<Difficulty>(
              items: [Difficulty.easy, Difficulty.medium, Difficulty.hard],
              isSelected: difficulty.contains,
              toggle: (diff) {
                setState(() {
                  if (difficulty.contains(diff)) {
                    difficulty.remove(diff);
                  } else {
                    difficulty.add(diff);
                  }
                });
              },
              title: difficultyToDescription,
              colorScheme: Theme.of(context).colorScheme,
            )
          ],
        ),
      ),
    );
  }
}
