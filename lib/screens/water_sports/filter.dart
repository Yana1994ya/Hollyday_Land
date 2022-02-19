import "package:flutter/material.dart";
import "package:hollyday_land/models/region.dart";
import "package:hollyday_land/models/water_sports/attraction_type.dart";
import "package:hollyday_land/models/water_sports/filter.dart";
import "package:hollyday_land/models/water_sports/filter_options.dart";
import "package:hollyday_land/screens/filter.dart";
import "package:hollyday_land/widgets/filter/chips.dart";

class WaterSportsFilterScreen extends AttractionFilterScreen<WaterSportsFilter,
    WaterSportsFilterOptions> {
  const WaterSportsFilterScreen(
      {Key? key, required WaterSportsFilter currentFilter})
      : super(key: key, currentFilter: currentFilter);

  @override
  String get pageTitle => "Water sports";

  @override
  Future<WaterSportsFilterOptions> loadOptions() =>
      WaterSportsFilterOptions.fetch();

  @override
  Widget selectionWidget(
          BuildContext context, WaterSportsFilterOptions options) =>
      _WaterSportsFilterScreen(
        options: options,
        initialFilter: currentFilter,
      );
}

class _WaterSportsFilterScreen extends StatefulWidget {
  final WaterSportsFilterOptions options;
  final WaterSportsFilter initialFilter;

  const _WaterSportsFilterScreen(
      {Key? key, required this.options, required this.initialFilter})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _WaterSportsFilterScreenState();
}

class _WaterSportsFilterScreenState extends State<_WaterSportsFilterScreen> {
  late WaterSportsFilter filter;

  @override
  void initState() {
    filter = widget.initialFilter;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Water sports"),
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
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Text(
              "Region:",
              style: Theme.of(context).textTheme.headline6,
            ),
            Container(
              height: 5,
            ),
            FilterChips<Region>(
              items: widget.options.regions,
              initialSelected: widget.initialFilter.regionIds,
              onChange: (regionIds) {
                filter = filter.copyWith(regionIds: regionIds);
              },
            ),
            Divider(),
            Text(
              "Trip Types:",
              style: Theme.of(context).textTheme.headline6,
            ),
            Container(
              height: 5,
            ),
            FilterChips<WaterSportsAttractionType>(
                items: widget.options.attractionTypes,
                initialSelected: widget.initialFilter.attractionTypeIds,
                onChange: (attractionTypeIds) {
                  filter =
                      filter.copyWith(attractionTypeIds: attractionTypeIds);
                })
          ],
        ),
      ),
    );
  }
}
