import 'package:flutter/material.dart';
import 'package:hollyday_land/models/museum/museum_domain.dart';
import 'package:hollyday_land/models/museum/museum_filter.dart';
import 'package:hollyday_land/models/museum/museum_filter_options.dart';
import 'package:hollyday_land/models/region.dart';
import 'package:hollyday_land/providers/museum/museum_filter.dart';
import 'package:hollyday_land/widgets/museum/filter_selection.dart';
import 'package:provider/provider.dart';

class MuseumsFilterScreen extends StatelessWidget {
  final MuseumFilter currentFilter;

  const MuseumsFilterScreen({Key? key, required this.currentFilter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = MuseumFilterProvider.fromFilter(currentFilter);

    return Scaffold(
      appBar: AppBar(
        title: Text("Museums"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop(provider.filter);
              },
              icon: Icon(Icons.save)),
        ],
      ),
      body: FutureBuilder(
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
              value: provider,
              child: FilterSelectionWidget(options: snapshot.data!),
            );
          }
        },
      ),
    );
    throw UnimplementedError();
  }
}


