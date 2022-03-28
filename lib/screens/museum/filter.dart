import "package:flutter/material.dart";
import "package:hollyday_land/models/museum/filter.dart";
import "package:hollyday_land/models/museum/filter_options.dart";
import "package:hollyday_land/models/museum/museum_domain.dart";
import "package:hollyday_land/models/region.dart";
import "package:hollyday_land/screens/filter.dart";
import "package:hollyday_land/widgets/filter/chips.dart";

class MuseumsFilterScreen
    extends AttractionFilterScreen<MuseumFilter, MuseumFilterOptions> {
  const MuseumsFilterScreen({Key? key, required MuseumFilter currentFilter})
      : super(key: key, currentFilter: currentFilter);

  @override
  String get pageTitle => "Museums";

  @override
  Future<MuseumFilterOptions> loadOptions() => MuseumFilterOptions.fetch();

  @override
  Widget selectionWidget(BuildContext context, MuseumFilterOptions options) =>
      _MuseumsFilter(
        options: options,
        initialFilter: currentFilter,
      );
}

class _MuseumsFilter extends StatefulWidget {
  final MuseumFilterOptions options;
  final MuseumFilter initialFilter;

  const _MuseumsFilter(
      {Key? key, required this.options, required this.initialFilter})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MuseumsFilterState();
}

class _MuseumsFilterState extends State<_MuseumsFilter> {
  late MuseumFilter filter;

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
        "Museums",
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
              "Domain:",
              style: Theme.of(context).textTheme.headline6,
            ),
            Container(
              height: 5,
            ),
            FilterChips<MuseumDomain>(
                items: widget.options.domains,
                initialSelected: widget.initialFilter.domainIds,
                onChange: (domainIds) {
                  setState(() {
                    filter = filter.copyWith(domainIds: domainIds);
                  });
                })
          ],
        ),
      ),
    );
  }
}
