import "package:flutter/material.dart";
import "package:hollyday_land/models/filter/region_filter.dart";
import "package:hollyday_land/models/region.dart";
import "package:hollyday_land/screens/filter.dart";
import "package:hollyday_land/widgets/filter/chips.dart";

class RegionFilterScreen
    extends AttractionFilterScreen<RegionFilter, List<Region>> {
  @override
  final String pageTitle;

  const RegionFilterScreen({
    Key? key,
    required RegionFilter currentFilter,
    required this.pageTitle,
  }) : super(key: key, currentFilter: currentFilter);

  @override
  Future<List<Region>> loadOptions() => regionObjects.readTags();

  @override
  Widget selectionWidget(BuildContext context, List<Region> options) =>
      _RegionFilterScreen(
        regions: options,
        initialFilter: currentFilter,
        pageTitle: pageTitle,
      );
}

class _RegionFilterScreen extends StatefulWidget {
  final List<Region> regions;
  final RegionFilter initialFilter;
  final String pageTitle;

  const _RegionFilterScreen({
    Key? key,
    required this.regions,
    required this.initialFilter,
    required this.pageTitle,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegionFilterScreenState();
}

class _RegionFilterScreenState extends State<_RegionFilterScreen> {
  late RegionFilter filter;

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
        widget.pageTitle,
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
              items: widget.regions,
              initialSelected: widget.initialFilter.regionIds,
              onChange: (regionIds) {
                filter = RegionFilter(regionIds);
              },
            ),
          ],
        ),
      ),
    );
  }
}
