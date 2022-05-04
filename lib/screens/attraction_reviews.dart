import "package:flutter/material.dart";
import "package:hollyday_land/models/comments.dart";
import "package:hollyday_land/providers/cache_key.dart";
import "package:hollyday_land/screens/reviews_page.dart";
import "package:provider/provider.dart";

class AttractionReviewsScreen extends StatefulWidget {
  final int attractionId;

  const AttractionReviewsScreen({Key? key, required this.attractionId})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AttractionReviewsScreenState();
}

class _AttractionReviewsScreenState extends State<AttractionReviewsScreen> {
  // Always start with the first screen
  int page = 1;

  @override
  Widget build(BuildContext context) {
    final cacheKey = Provider.of<CacheKey>(context).cacheKey;

    return FutureBuilder<Comments>(
      future: Comments.readAttractionComments(
        widget.attractionId,
        page,
        cacheKey,
      ),
      builder: (BuildContext _ctx, AsyncSnapshot<Comments> snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text("Reviews")),
            body: Center(child: Text("error: ${snapshot.error}")),
          );
        } else if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(title: Text("Reviews")),
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          return ReviewsPage(
            comments: snapshot.data!,
            openPage: (newPage) {
              setState(() {
                page = newPage;
              });
            },
            attractionId: widget.attractionId,
          );
        }
      },
    );
  }
}
