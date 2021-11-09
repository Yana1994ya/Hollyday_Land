import 'package:flutter/material.dart';
import 'package:hollyday_land/models/museum/museum_filter.dart';
import 'package:hollyday_land/models/museum/museum_short.dart';
import 'package:hollyday_land/screens/museums_filter.dart';

class MuseumsScreen extends StatefulWidget {
  static const routePath = "/museums";

  @override
  State<StatefulWidget> createState() => _MuseumsScreenState();
}

class _MuseumsScreenState extends State<MuseumsScreen> {
  MuseumFilter filter = MuseumFilter.empty();

  void filterSelectionResult(dynamic value) {
    if (value != null) {
      setState(() {
        filter = value as MuseumFilter;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Museums"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                      builder: (_) =>
                          MuseumsFilterScreen(currentFilter: filter),
                    ))
                    .then(filterSelectionResult);
              },
              icon: Icon(Icons.tune)),
        ],
      ),
      body: FutureBuilder(
        future: MuseumShort.readMuseums(filter),
        builder: (_, AsyncSnapshot<List<MuseumShort>> snapshot) {
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
            List<MuseumShort> museums = snapshot.data!;

            return Center(
              child: Text("found ${museums.length} museums"),
            );
          }
        },
      ),
    );
  }
}
