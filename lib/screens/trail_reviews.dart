import "package:flutter/material.dart";
import "package:hollyday_land/api_server.dart";
import "package:hollyday_land/models/comments.dart";
import "package:hollyday_land/providers/trail/cache_key.dart";
import "package:hollyday_land/screens/reviews_page.dart";
import "package:provider/provider.dart";

class TrailReviewsScreen extends StatefulWidget {
  final String trailId;

  const TrailReviewsScreen({Key? key, required this.trailId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TrailReviewsScreenState();
}

class _TrailReviewsScreenState extends State<TrailReviewsScreen> {
  // Always start with the first screen
  int page = 1;

  @override
  Widget build(BuildContext context) {
    final trailsCacheKey = Provider.of<TrailsCacheKey>(context).cacheKey;

    return FutureBuilder<Comments>(
      future: Comments.readTrailComments(
        widget.trailId,
        page,
        trailsCacheKey,
      ),
      builder: (BuildContext _ctx, AsyncSnapshot<Comments> snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text("Comments")),
            body: Center(child: Text("error: ${snapshot.error}")),
          );
        } else if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(title: Text("Comments")),
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
            newReview: (ctx, review) {
              final requestBody = {
                "token": review.hdToken,
                "trail_id": widget.trailId,
                "rating": review.rating,
                "image_ids": review.imageIds
              };

              if (review.text.isNotEmpty) {
                requestBody["text"] = review.text;
              }

              return ApiServer.post(
                "attractions/api/comments/trail",
                "comment_id",
                requestBody,
              ).then((commentId) {
                Provider.of<TrailsCacheKey>(context, listen: false).refresh();

                return commentId as int;
              });
            },
          );
        }
      },
    );
  }
}
