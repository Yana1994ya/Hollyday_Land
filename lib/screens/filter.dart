import "package:flutter/material.dart";
import "package:hollyday_land/models/filter/attraction_filter.dart";
import "package:hollyday_land/providers/filter.dart";

abstract class AttractionFilterScreen extends StatelessWidget {
  final AttractionFilter currentFilter;

  const AttractionFilterScreen({Key? key, required this.currentFilter})
      : super(key: key);

  String get pageTitle;

  Widget selectionWidget(BuildContext context, FilterProvider filterProvider);

  @override
  Widget build(BuildContext context) {
    FilterProvider filterProvider = currentFilter.createProvider();

    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop(filterProvider.currentState);
              },
              icon: Icon(Icons.save)),
        ],
      ),
      body: selectionWidget(context, filterProvider),
    );
  }
}
