import 'package:flutter/material.dart';
import 'package:hollyday_land/models/museum/museum_filter.dart';
import 'package:hollyday_land/models/museum/museum_short.dart';
import 'package:hollyday_land/screens/museum/museums_filter.dart';
import 'package:hollyday_land/widgets/museum/list_item.dart';

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

            return ListView.builder(
              itemBuilder: (_, index) => index == 0
                  ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("found ${museums.length} museums"),
                  )
                  : MuseumListItem(museum: museums[index - 1]),
              itemCount: museums.length + 1,
            );
          }
        },
      ),
    );
  }
}
