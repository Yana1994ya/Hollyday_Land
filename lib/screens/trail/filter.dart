import "package:flutter/material.dart";
import "package:hollyday_land/models/trail/difficulty.dart";
import "package:hollyday_land/models/trail/filter.dart";

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Trails filter"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop(TrailsFilter(
                  difficulty: difficulty,
                  length: lengthRange,
                  elevationGain: elvGainRange));
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Column(
        children: [
          Text("Minimum length"),
          Slider(
            value: lengthRange.rangeStart == null
                ? 0.0
                : lengthRange.rangeStart!.toDouble(),
            min: 0,
            max: 20000,
            divisions: 1000,
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
          Text("Maximum length"),
          Slider(
            value: lengthRange.rangeEnd == null
                ? 20000
                : lengthRange.rangeEnd!.toDouble(),
            min: 1000,
            max: 20000,
            divisions: 1000,
            onChanged: (newValue) {
              setState(() {
                if (newValue == 20000) {
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
          Text("Minimum Elevation Gain"),
          Slider(
            value: elvGainRange.rangeStart == null
                ? 0.0
                : elvGainRange.rangeStart!.toDouble(),
            min: 0,
            max: 4000,
            divisions: 100,
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
          Text("Maximum Elevation Gain"),
          Slider(
            value: elvGainRange.rangeEnd == null
                ? 4000
                : elvGainRange.rangeEnd!.toDouble(),
            min: 100,
            max: 4000,
            divisions: 100,
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
          Row(
            children: [
              ChoiceChip(
                label: Text("Easy"),
                selected: difficulty.contains(Difficulty.easy),
                onSelected: (value) {
                  setState(() {
                    if (value) {
                      difficulty.add(Difficulty.easy);
                    } else {
                      difficulty.remove(Difficulty.easy);
                    }
                  });
                },
              ),
              ChoiceChip(
                label: Text("Moderate"),
                selected: difficulty.contains(Difficulty.medium),
                onSelected: (value) {
                  setState(() {
                    if (value) {
                      difficulty.add(Difficulty.medium);
                    } else {
                      difficulty.remove(Difficulty.medium);
                    }
                  });
                },
              ),
              ChoiceChip(
                label: Text("Hard"),
                selected: difficulty.contains(Difficulty.hard),
                onSelected: (value) {
                  setState(() {
                    if (value) {
                      difficulty.add(Difficulty.hard);
                    } else {
                      difficulty.remove(Difficulty.hard);
                    }
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
