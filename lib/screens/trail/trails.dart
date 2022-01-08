import "package:flutter/material.dart";
import "package:hollyday_land/models/trail/filter.dart";
import "package:hollyday_land/models/trail/short.dart";
import 'package:hollyday_land/screens/trail/record.dart';
import "package:hollyday_land/widgets/trail/trail_list_item.dart";

class TrailsScreen extends StatefulWidget {
  static const routePath = "/trails";

  @override
  State<StatefulWidget> createState() {
    return _TrailsScreenState();
  }
}

class _TrailsScreenState extends State<TrailsScreen> {
  TrailsFilter trailsFilter = TrailsFilter.empty();

  @override
  Widget build(BuildContext context) {
    final body = FutureBuilder(
      future: TrailShort.readTrails(trailsFilter.parameters),
      builder: (BuildContext _, AsyncSnapshot<List<TrailShort>> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error!.toString()));
        } else if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          final trails = snapshot.data!;
          return ListView.builder(
            itemBuilder: (_, index) => TrailListItem(trail: trails[index]),
            itemCount: trails.length,
          );
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Trails"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(TrailRecordScreen.routePath);
              },
              icon: Icon(Icons.fiber_manual_record))
        ],
      ),
      body: body,
    );
  }
}
