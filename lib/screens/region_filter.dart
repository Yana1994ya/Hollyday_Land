import "package:flutter/material.dart";
import "package:hollyday_land/models/filter/attraction_filter.dart";
import "package:hollyday_land/models/region.dart";
import "package:hollyday_land/providers/filter.dart";
import "package:hollyday_land/providers/region_filter.dart";
import "package:hollyday_land/screens/filter.dart";
import "package:hollyday_land/widgets/filter/region_filter_selection.dart";
import "package:provider/provider.dart";

class RegionFilterScreen extends AttractionFilterScreen {
  @override
  final String pageTitle;

  const RegionFilterScreen({
    Key? key,
    required AttractionFilter currentFilter,
    required this.pageTitle,
  }) : super(key: key, currentFilter: currentFilter);

  @override
  Widget selectionWidget(BuildContext context, FilterProvider filterProvider) {
    return FutureBuilder(
      future: Region.readRegions(),
      builder: (_, AsyncSnapshot<List<Region>> snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: Text(
            snapshot.error.toString(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
            ),
          ));
        } else if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ChangeNotifierProvider.value(
            value: filterProvider as RegionFilterProvider,
            child: RegionFilterSelectionWidget(
              regionOptions: snapshot.data!,
            ),
          );
        }
      },
    );
  }
}
