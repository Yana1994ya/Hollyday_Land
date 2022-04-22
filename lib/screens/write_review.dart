import "package:flutter/material.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";
import "package:hollyday_land/api_server.dart";
import "package:hollyday_land/models/comments.dart";
import "package:hollyday_land/models/image_upload.dart";
import "package:hollyday_land/providers/cache_key.dart";
import "package:hollyday_land/providers/login.dart";
import "package:hollyday_land/screens/profile.dart";
import "package:hollyday_land/widgets/image_upload.dart";
import "package:image_picker/image_picker.dart";
import "package:provider/provider.dart";

class WriteReview extends StatelessWidget {
  final int attractionId;

  WriteReview({
    Key? key,
    required this.attractionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final login = Provider.of<LoginProvider>(context);

    return login.hdToken == null
        ? Scaffold(
            appBar: AppBar(
              title: Text("Write a review"),
            ),
            body: ProfileScreen.loginBody(login),
          )
        : _LoggedInWriteReview(
            attractionId: attractionId,
            hdToken: login.hdToken!,
          );
  }
}

class _LoggedInWriteReview extends StatefulWidget {
  final int attractionId;
  final String hdToken;

  const _LoggedInWriteReview({
    Key? key,
    required this.attractionId,
    required this.hdToken,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoggedInWriteReviewState();
}

class _LoggedInWriteReviewState extends State<_LoggedInWriteReview> {
  double _ratingValue = 0;
  bool _imageUploading = false;
  bool _publishing = false;
  final List<ImageUpload> _uploadedImages = [];
  final bodyController = TextEditingController();

  List<Widget> _imagesWrap() {
    List<Widget> result = [];

    for (var image in _uploadedImages) {
      final thumb = image.thumbs.firstWhere(
        (t) => t.width == 64 || t.height == 64,
      );

      result.add(Image.network(
        thumb.url,
        width: thumb.width.toDouble(),
        height: thumb.height.toDouble(),
      ));
    }

    if (_imageUploading) {
      result.add(
        SizedBox(
          width: 64,
          height: 64,
          child: CircularProgressIndicator(),
        ),
      );
    }

    return result;
  }

  Future<int> publishReview(NewReview review) {
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
      Provider.of<CacheKey>(context, listen: false).refresh();

      return commentId as int;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Write a review"),
          actions: [
            ImageUploadWidget(
              abort: () {
                setState(() {
                  _imageUploading = false;
                });
              },
              pickedImage: (XFile picture) async {
                final image =
                    await ImageUpload.uploadImage(picture, widget.hdToken);

                setState(() {
                  _uploadedImages.add(image);
                  _imageUploading = false;
                });
              },
              pickingImage: () {
                setState(() {
                  _imageUploading = true;
                });
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                RatingBar(
                  initialRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  ratingWidget: RatingWidget(
                      full: const Icon(Icons.star, color: Colors.orange),
                      half: const Icon(
                        Icons.star_half,
                        color: Colors.orange,
                      ),
                      empty: const Icon(
                        Icons.star_outline,
                        color: Colors.orange,
                      )),
                  onRatingUpdate: (value) {
                    setState(() {
                      _ratingValue = value;
                    });
                  },
                ),
                Text("Add a comment:"),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  controller: bodyController,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                if (_uploadedImages.isNotEmpty || _imageUploading)
                  Text("images:"),
                if (_uploadedImages.isNotEmpty || _imageUploading)
                  Wrap(
                    spacing: 8.0,
                    children: _imagesWrap(),
                  ),
                if (!_publishing && _ratingValue > 0)
                  TextButton(
                    onPressed: () {
                      final newReview = NewReview(
                        rating: _ratingValue.toInt(),
                        text: bodyController.value.text.trim(),
                        imageIds: _uploadedImages
                            .map((image) => image.imageId)
                            .toList(),
                        hdToken: widget.hdToken,
                      );

                      setState(() {
                        _publishing = true;
                      });

                      publishReview(newReview)
                          .then(
                              (reviewId) => Navigator.of(context).pop(reviewId))
                          .catchError((err) {
                        final snackBar = SnackBar(
                          content: Text(err.toString()),
                        );

                        // Find the ScaffoldMessenger in the widget tree
                        // and use it to show a SnackBar.
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        setState(() {
                          _publishing = false;
                        });
                      });
                    },
                    child: Text("Publish comment"),
                  ),
                if (_publishing)
                  SizedBox(
                    width: 64,
                    height: 64,
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
        ));
  }
}
