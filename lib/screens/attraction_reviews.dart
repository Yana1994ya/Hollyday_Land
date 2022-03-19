import "package:flutter/material.dart";
import "package:hollyday_land/api_server.dart";
import "package:hollyday_land/models/comments.dart";
import "package:hollyday_land/providers/rating.dart";
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
    final ratingCacheKey = Provider.of<RatingCacheKey>(context).cacheKey;

    return FutureBuilder<Comments>(
      future: Comments.readAttractionComments(
        widget.attractionId,
        page,
        ratingCacheKey,
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
                "attraction_id": widget.attractionId,
                "rating": review.rating,
                "image_ids": review.imageIds
              };

              if (review.text.isNotEmpty) {
                requestBody["text"] = review.text;
              }

              return ApiServer.post(
                "attractions/api/comments/attraction",
                "comment_id",
                requestBody,
              ).then((commentId) {
                Provider.of<RatingCacheKey>(context, listen: false).refresh();

                return commentId as int;
              });
            },
          );
        }
      },
    );
  }
}
