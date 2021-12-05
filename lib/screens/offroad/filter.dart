import "package:flutter/material.dart";
import "package:hollyday_land/models/offroad/filter.dart";
import "package:hollyday_land/models/offroad/filter_options.dart";
import "package:hollyday_land/providers/filter.dart";
import "package:hollyday_land/providers/offroad/filter.dart";
import "package:hollyday_land/screens/filter.dart";
import "package:hollyday_land/widgets/filter/offroad.dart";
import "package:provider/provider.dart";

class OffRoadTripFilterScreen extends AttractionFilterScreen {
  const OffRoadTripFilterScreen(
      {Key? key, required OffRoadTripFilter currentFilter})
      : super(key: key, currentFilter: currentFilter);

  @override
  String get pageTitle => "Off Road Trips";

  @override
  Widget selectionWidget(BuildContext context, FilterProvider filterProvider) {
    return FutureBuilder(
      future: OffRoadTripFilterOptions.fetch(),
      builder: (_, AsyncSnapshot<OffRoadTripFilterOptions> snapshot) {
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
            value: filterProvider as OffRoadTripFilterProvider,
            child: OffRoadTripFilterSelectionWidget(options: snapshot.data!),
          );
        }
      },
    );
  }
}
