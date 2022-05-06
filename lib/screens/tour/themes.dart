import "package:built_collection/built_collection.dart";
import "package:flutter/material.dart";
import "package:hollyday_land/models/tour/tour_theme.dart";
import "package:hollyday_land/screens/tour/tours.dart";

class TourThemeSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select by theme"),
      ),
      body: FutureBuilder<List<TourTheme>>(
        future: tourThemeObjects.readTags(),
        builder: (_, AsyncSnapshot<List<TourTheme>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            final List<TourTheme> themes = snapshot.data!;

            return ListView.builder(
              itemBuilder: (_, index) {
                final TourTheme theme = themes[index];
                return ListTile(
                  title: Text(themes[index].name),
                  trailing: TextButton(
                    child: const Text("view"),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return ToursScreen(
                          parameters: BuiltMap.of({
                            "theme_id": [theme.id.toString()]
                          }),
                        );
                      }));
                    },
                  ),
                );
              },
              itemCount: themes.length,
            );
          }
        },
      ),
    );
  }
}
