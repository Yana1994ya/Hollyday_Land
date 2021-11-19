import "package:flutter/material.dart";
import 'package:hollyday_land/models/attraction_filter.dart';
import 'package:hollyday_land/models/attraction_filter_options.dart';
import 'package:hollyday_land/providers/attraction_filter.dart';
import 'package:hollyday_land/widgets/filter_selection.dart';
import "package:provider/provider.dart";

abstract class AttractionFilterScreen<
        Options extends AttractionFilterOptions,
        Filter extends AttractionFilter,
        ProviderType extends AttractionFilterProvider<AttractionFilter>>
    extends StatelessWidget {
  final Filter currentFilter;

  const AttractionFilterScreen({Key? key, required this.currentFilter})
      : super(key: key);

  String get pageTitle;

  ProviderType createProvider();

  AttractionFilterSelectionWidget<Options, Filter, ProviderType>
      selectionWidget(Options options);

  Future<Options> fetchOptions();

  @override
  Widget build(BuildContext context) {
    final provider = createProvider();

    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop(provider.filter);
              },
              icon: Icon(Icons.save)),
        ],
      ),
      body: FutureBuilder(
        future: fetchOptions(),
        builder: (_, AsyncSnapshot<Options> snapshot) {
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
              child: selectionWidget(snapshot.data!),
            );
          }
        },
      ),
    );
  }
}
