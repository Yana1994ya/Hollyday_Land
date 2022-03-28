import "package:flutter/material.dart";
import "package:hollyday_land/models/region.dart";
import "package:hollyday_land/models/rock_climbing/attraction_type.dart";
import "package:hollyday_land/models/rock_climbing/filter.dart";
import "package:hollyday_land/models/rock_climbing/filter_options.dart";
import "package:hollyday_land/screens/filter.dart";
import "package:hollyday_land/widgets/filter/chips.dart";

class RockClimbingFilterScreen extends AttractionFilterScreen<
    RockClimbingFilter, RockClimbingFilterOptions> {
  const RockClimbingFilterScreen(
      {Key? key, required RockClimbingFilter currentFilter})
      : super(key: key, currentFilter: currentFilter);

  @override
  String get pageTitle => "Rock climbing";

  @override
  Future<RockClimbingFilterOptions> loadOptions() =>
      RockClimbingFilterOptions.fetch();

  @override
  Widget selectionWidget(
          BuildContext context, RockClimbingFilterOptions options) =>
      _RockClimbingFilterScreen(
        options: options,
        initialFilter: currentFilter,
      );
}

class _RockClimbingFilterScreen extends StatefulWidget {
  final RockClimbingFilterOptions options;
  final RockClimbingFilter initialFilter;

  const _RockClimbingFilterScreen(
      {Key? key, required this.options, required this.initialFilter})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _RockClimbingFilterScreenState();
}

class _RockClimbingFilterScreenState extends State<_RockClimbingFilterScreen> {
  late RockClimbingFilter filter;

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
        "Rock climbing",
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
                setState(() {
                  filter = filter.copyWith(regionIds: regionIds);
                });
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
            FilterChips<RockClimbingAttractionType>(
                items: widget.options.attractionTypes,
                initialSelected: widget.initialFilter.attractionTypeIds,
                onChange: (attractionTypeIds) {
                  setState(() {
                    filter =
                        filter.copyWith(attractionTypeIds: attractionTypeIds);
                  });
                })
          ],
        ),
      ),
    );
  }
}
