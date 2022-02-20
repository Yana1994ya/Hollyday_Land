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
      _MuseumsFilterScreen(
        options: options,
        initialFilter: currentFilter,
      );
}

class _MuseumsFilterScreen extends StatefulWidget {
  final MuseumFilterOptions options;
  final MuseumFilter initialFilter;

  const _MuseumsFilterScreen(
      {Key? key, required this.options, required this.initialFilter})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MuseumsFilterScreenState();
}

class _MuseumsFilterScreenState extends State<_MuseumsFilterScreen> {
  late MuseumFilter filter;

  @override
  void initState() {
    filter = widget.initialFilter;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Museums"),
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
                filter = filter.withRegionIds(regionIds);
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
                  filter = filter.withDomainIds(domainIds);
                })
          ],
        ),
      ),
    );
  }
}
