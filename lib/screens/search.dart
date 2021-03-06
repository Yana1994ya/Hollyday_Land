import "package:flutter/material.dart";
import "package:hollyday_land/api_server.dart";
import "package:hollyday_land/models/generic_attraction.dart";
import 'package:hollyday_land/providers/location_provider.dart';
import "package:hollyday_land/widgets/generic_list_item.dart";
import "package:hollyday_land/widgets/no_results.dart";
import 'package:provider/provider.dart';

class SearchResults {
  final int numPages;
  final List<GenericAttraction> items;

  SearchResults({
    required this.numPages,
    required this.items,
  });

  static Future<SearchResults> search(
    String query,
    int page,
  ) {
    final Map<String, Iterable<String>> params = {};
    params["q"] = [query];
    params["page"] = [page.toString()];

    return ApiServer.get("/attractions/api/search", "page", params)
        .then((json) {
      final List<dynamic> items = json["items"];

      return SearchResults(
        numPages: json["num_pages"],
        items: items.map((item) => GenericAttraction.fromJson(item)).toList(),
      );
    });
  }
}

class SearchScreen extends StatefulWidget {
  static const routePath = "/search";

  @override
  State<StatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String query = "";

  @override
  Widget build(BuildContext context) {
    // Ask for location permissions for distance metric
    Provider.of<LocationProvider>(context, listen: false).retrieveLocation();

    return Scaffold(
        appBar: AppBar(
          // The search area here
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                controller: _controller,
                decoration: InputDecoration(
                  isCollapsed: true,
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _controller.text = "";
                        query = "";
                      });
                    },
                  ),
                  hintText: "Search by name",
                  border: InputBorder.none,
                ),
                onSubmitted: (value) {
                  setState(() {
                    query = value;
                  });
                },
              ),
            ),
          ),
        ),
        body: query.isEmpty
            ? Center(
          child: Image(
            image: AssetImage("assets/graphics/search.png"),
          ),
        )
            : FutureBuilder(
          future: SearchResults.search(query, 1),
          builder: (_, AsyncSnapshot<SearchResults> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error!.toString()),
              );
            } else if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              SearchResults results = snapshot.data!;

              if (results.items.isEmpty) {
                return NoResults(text: "No search results for: $query");
              } else {
                return ListView.builder(
                  itemBuilder: (_, index) =>
                      GenericListItem(attraction: results.items[index]),
                  itemCount: results.items.length,
                );
              }
            }
          },
        ));
  }
}
