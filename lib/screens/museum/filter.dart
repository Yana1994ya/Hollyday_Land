import "package:flutter/material.dart";
import "package:hollyday_land/models/museum/filter.dart";
import "package:hollyday_land/models/museum/filter_options.dart";
import "package:hollyday_land/providers/filter.dart";
import "package:hollyday_land/providers/museum/filter.dart";
import "package:hollyday_land/screens/filter.dart";
import "package:hollyday_land/widgets/filter/museum.dart";
import "package:provider/provider.dart";

class MuseumsFilterScreen extends AttractionFilterScreen {
  const MuseumsFilterScreen({Key? key, required MuseumFilter currentFilter})
      : super(key: key, currentFilter: currentFilter);

  @override
  String get pageTitle => "Museums";

  @override
  Widget selectionWidget(BuildContext context, FilterProvider filterProvider) {
    return FutureBuilder(
      future: MuseumFilterOptions.fetch(),
      builder: (_, AsyncSnapshot<MuseumFilterOptions> snapshot) {
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
            value: filterProvider as MuseumFilterProvider,
            child: MuseumFilterSelectionWidget(options: snapshot.data!),
          );
        }
      },
    );
  }
}
