import "package:flutter/material.dart";
import "package:hollyday_land/models/museum/filter.dart";
import "package:hollyday_land/models/tour/destination.dart";
import "package:hollyday_land/models/tour/filter.dart";
import "package:hollyday_land/models/tour/filter_options.dart";
import "package:hollyday_land/models/tour/package.dart";
import "package:hollyday_land/models/tour/tour_language.dart";
import "package:hollyday_land/screens/filter.dart";
import "package:hollyday_land/widgets/filter/chips.dart";

class TourFilterScreen
    extends AttractionFilterScreen<TourFilter, TourFilterOptions> {
  const TourFilterScreen({Key? key, required TourFilter currentFilter})
      : super(key: key, currentFilter: currentFilter);

  @override
  String get pageTitle => "Tours";

  @override
  Future<TourFilterOptions> loadOptions() => TourFilterOptions.retrieve();

  @override
  Widget selectionWidget(BuildContext context, TourFilterOptions options) =>
      _TourFilter(
        options: options,
        initialFilter: currentFilter,
      );
}

class _TourFilter extends StatefulWidget {
  final TourFilterOptions options;
  final TourFilter initialFilter;

  const _TourFilter(
      {Key? key, required this.options, required this.initialFilter})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TourFilterState();
}

class _TourFilterState extends State<_TourFilter> {
  late TourFilter filter;

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
        "Tours",
        filter,
        MuseumFilter.empty(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Text(
              "Destinations:",
              style: Theme.of(context).textTheme.headline6,
            ),
            Container(
              height: 5,
            ),
            FilterChips<TourDestination>(
              items: widget.options.tourDestination,
              initialSelected: widget.initialFilter.destinationIds,
              onChange: (destinationIds) {
                setState(() {
                  filter = filter.copyWith(destinationIds: destinationIds);
                });
              },
            ),
            Divider(),
            Text(
              "Language:",
              style: Theme.of(context).textTheme.headline6,
            ),
            Container(
              height: 5,
            ),
            FilterChips<TourLanguage>(
                items: widget.options.tourLanguage,
                initialSelected: widget.initialFilter.tourLanguageIds,
                onChange: (tourLanguageIds) {
                  setState(() {
                    filter = filter.copyWith(tourLanguageIds: tourLanguageIds);
                  });
                }),
            Divider(),
            Text(
              "Package:",
              style: Theme.of(context).textTheme.headline6,
            ),
            Container(
              height: 5,
            ),
            FilterChips<Package>(
                items: widget.options.package,
                initialSelected: widget.initialFilter.packageIds,
                onChange: (packageIds) {
                  setState(() {
                    filter = filter.copyWith(packageIds: packageIds);
                  });
                }),
          ],
        ),
      ),
    );
  }
}
