import "package:flutter/material.dart";
import "package:hollyday_land/models/comments.dart";
import "package:hollyday_land/models/date_formatter.dart";
import 'package:hollyday_land/screens/full_screen_image.dart';
import "package:hollyday_land/screens/write_review.dart";
import "package:hollyday_land/widgets/no_results.dart";

class ReviewsPage extends StatelessWidget {
  final Comments comments;
  final void Function(int) openPage;
  final int attractionId;

  const ReviewsPage({
    Key? key,
    required this.comments,
    required this.openPage,
    required this.attractionId,
  }) : super(key: key);

  Widget prevPage() {
    if (comments.page > 1) {
      return TextButton(
          onPressed: () {
            openPage(comments.page - 1);
          },
          child: Text("<"));
    } else {
      return TextButton(onPressed: null, child: Text("<"));
    }
  }

  Widget nextPage() {
    if (comments.page < comments.pages) {
      return TextButton(
          onPressed: () {
            openPage(comments.page + 1);
          },
          child: Text(">"));
    } else {
      return TextButton(onPressed: null, child: Text(">"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reviews")),
      body: comments.comments.isEmpty
          ? const NoResults(text: "No reviews yet.")
          : ListView.builder(
              itemCount: comments.comments.length,
              itemBuilder: (_ctx, index) {
                final comment = comments.comments[index];
                final dynamic image;

                if (comment.user.picture == null) {
                  image = AssetImage("assets/graphics/icon.png");
                } else {
                  image = NetworkImage(comment.user.picture!);
                }
                final dateString =
              DateFormatter.getVerboseDateTimeRepresentation(comment.created);
          return ListTile(
            title: Text(comment.user.name),
            leading: CircleAvatar(
              backgroundImage: image,
            ),
            subtitle: Column(
              children: [
                Align(
                  child: Text(
                    "rating: ${comment.rating}",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  alignment: Alignment.topLeft,
                ),
                if (comment.text != null)
                  Padding(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        comment.text!,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 5),
                  ),
                if (comment.images.isNotEmpty)
                  Wrap(
                    spacing: 8.0,
                    children: comment.images.map((image) {
                            return GestureDetector(
                              child: Image.network(
                                image.url,
                                width: image.width.toDouble(),
                                height: image.height.toDouble(),
                              ),
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_ctx) {
                                  return FullScreenImage(
                                    image: image.parent == null
                                        ? image
                                        : image.parent!,
                                  );
                                }));
                              },
                            );
                          }).toList(),
                  ),
                Align(
                  child: Text(dateString),
                  alignment: Alignment.topLeft,
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.edit),
        label: const Text("Write a review"),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => WriteReview(
              attractionId: attractionId,
            ),
          ));
        },
      ),
      bottomNavigationBar: comments.pages <= 1
          ? null
          : BottomAppBar(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  prevPage(),
                  nextPage(),
                ],
              ),
            ),
    );
  }
}
