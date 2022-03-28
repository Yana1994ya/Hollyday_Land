import "package:flutter/material.dart";
import "package:hollyday_land/models/filter/attraction_filter.dart";

abstract class AttractionFilterScreen<Filter extends AttractionFilter, Options>
    extends StatelessWidget {
  final Filter currentFilter;

  const AttractionFilterScreen({Key? key, required this.currentFilter})
      : super(key: key);

  String get pageTitle;

  Widget selectionWidget(BuildContext context, Options options);

  Future<Options> loadOptions();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Options>(
        future: loadOptions(),
        builder: (ctx, AsyncSnapshot<Options> snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text(pageTitle),
              ),
              body: Center(
                child: Text(
                  snapshot.error.toString(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
            );
          } else if (!snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text(pageTitle),
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return selectionWidget(ctx, snapshot.data!);
          }
        });
  }

  static AppBar filterAppBar(
    BuildContext context,
    String title,
    AttractionFilter filter,
  ) {
    return AppBar(
      title: Text(title),
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
    );
  }
}
