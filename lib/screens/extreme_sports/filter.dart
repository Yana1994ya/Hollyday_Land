import "package:flutter/material.dart";
import "package:hollyday_land/models/extreme_sports/filter.dart";
import "package:hollyday_land/models/extreme_sports/filter_options.dart";
import "package:hollyday_land/models/extreme_sports/types.dart";
import "package:hollyday_land/models/region.dart";
import "package:hollyday_land/screens/filter.dart";
import "package:hollyday_land/widgets/filter/chips.dart";

class ExtremeSportsFilterScreen extends AttractionFilterScreen<
    ExtremeSportsFilter, ExtremeSportsFilterOptions> {
  const ExtremeSportsFilterScreen(
      {Key? key, required ExtremeSportsFilter currentFilter})
      : super(key: key, currentFilter: currentFilter);

  @override
  String get pageTitle => "Extreme sports";

  @override
  Future<ExtremeSportsFilterOptions> loadOptions() =>
      ExtremeSportsFilterOptions.fetch();

  @override
  Widget selectionWidget(
          BuildContext context, ExtremeSportsFilterOptions options) =>
      _ExtremeSportsFilterScreen(
        options: options,
        initialFilter: currentFilter,
      );
}

class _ExtremeSportsFilterScreen extends StatefulWidget {
  final ExtremeSportsFilterOptions options;
  final ExtremeSportsFilter initialFilter;

  const _ExtremeSportsFilterScreen(
      {Key? key, required this.options, required this.initialFilter})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExtremeSportsFilterScreenState();
}

class _ExtremeSportsFilterScreenState
    extends State<_ExtremeSportsFilterScreen> {
  late ExtremeSportsFilter filter;

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
        "Extreme sports",
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
            FilterChips<ExtremeSportsType>(
                items: widget.options.types,
                initialSelected: widget.initialFilter.typeIds,
                onChange: (attractionTypeIds) {
                  setState(() {
                    filter = filter.copyWith(typeIds: attractionTypeIds);
                  });
                })
          ],
        ),
      ),
    );
  }
}
