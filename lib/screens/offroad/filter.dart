import "package:flutter/material.dart";
import "package:hollyday_land/models/offroad/filter.dart";
import "package:hollyday_land/models/offroad/filter_options.dart";
import "package:hollyday_land/models/offroad/trip_type.dart";
import "package:hollyday_land/models/region.dart";
import "package:hollyday_land/screens/filter.dart";
import "package:hollyday_land/widgets/filter/chips.dart";

class OffRoadFilterScreen extends AttractionFilterScreen<OffRoadTripFilter,
    OffRoadTripFilterOptions> {
  const OffRoadFilterScreen(
      {Key? key, required OffRoadTripFilter currentFilter})
      : super(key: key, currentFilter: currentFilter);

  @override
  String get pageTitle => "Off Road Trips";

  @override
  Future<OffRoadTripFilterOptions> loadOptions() =>
      OffRoadTripFilterOptions.fetch();

  @override
  Widget selectionWidget(
          BuildContext context, OffRoadTripFilterOptions options) =>
      _OffRoadFilterScreen(
        options: options,
        initialFilter: currentFilter,
      );
}

class _OffRoadFilterScreen extends StatefulWidget {
  final OffRoadTripFilterOptions options;
  final OffRoadTripFilter initialFilter;

  const _OffRoadFilterScreen(
      {Key? key, required this.options, required this.initialFilter})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _OffRoadFilterScreenState();
}

class _OffRoadFilterScreenState extends State<_OffRoadFilterScreen> {
  late OffRoadTripFilter filter;

  @override
  void initState() {
    filter = widget.initialFilter;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AttractionFilterScreen.filterAppBar(
        context,
        "Off Road Trips",
        filter,
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
                filter = filter.withRegionIds(regionIds);
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
            FilterChips<OffRoadTripType>(
                items: widget.options.tripTypes,
                initialSelected: widget.initialFilter.tripTypeIds,
                onChange: (tripTypeIds) {
                  filter = filter.withTripTypeIds(tripTypeIds);
                })
          ],
        ),
      ),
    );
  }
}
