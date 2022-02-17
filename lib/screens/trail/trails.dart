import "package:flutter/material.dart";
import "package:hollyday_land/models/trail/filter.dart";
import "package:hollyday_land/models/trail/short.dart";
import "package:hollyday_land/providers/trail/cache_key.dart";
import "package:hollyday_land/screens/trail/filter.dart";
import "package:hollyday_land/screens/trail/record.dart";
import "package:hollyday_land/widgets/trail/trail_list_item.dart";
import "package:provider/provider.dart";

class TrailsScreen extends StatefulWidget {
  static const routePath = "/trails";

  @override
  State<StatefulWidget> createState() {
    return _TrailsScreenState();
  }
}

class _TrailsScreenState extends State<TrailsScreen> {
  TrailsFilter trailsFilter = TrailsFilter.empty();

  Widget actionsMenu() {
    return PopupMenuButton(
      onSelected: (index) {
        if (index == 1) {
          Navigator.of(context)
              .pushNamed(TrailRecordScreen.routePath)
              .then((value) {
            // If upload was successful, true is returned via pop
            if (value == true) {
              // Trigger refresh
              Provider.of<TrailsCacheKey>(context, listen: false).refresh();
            }
          });
        } else if (index == 2) {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              builder: (_) => TrailsFilterScreen(initialFilter: trailsFilter),
            ),
          )
              .then((value) {
            if (value != null) {
              setState(() {
                trailsFilter = value as TrailsFilter;
              });
            }
          });
        }
      },
      itemBuilder: (context) => <PopupMenuEntry<int>>[
        PopupMenuItem<int>(
          value: 1,
          child: Row(
            children: [
              Icon(
                Icons.fiber_manual_record,
                color: Colors.black,
              ),
              Text("Record"),
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 2,
          child: Row(
            children: [
              Icon(
                Icons.filter_list,
                color: Colors.black,
              ),
              Text("Filter"),
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 3,
          child: Row(
            children: [
              Icon(
                Icons.map,
                color: Colors.black,
              ),
              Text("Map"),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    TrailsCacheKey cacheKey = Provider.of<TrailsCacheKey>(context);

    final body = FutureBuilder(
      future: TrailShort.readTrails(trailsFilter.parameters(cacheKey.cacheKey)),
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
        actions: [actionsMenu()],
      ),
      body: body,
    );
  }
}
