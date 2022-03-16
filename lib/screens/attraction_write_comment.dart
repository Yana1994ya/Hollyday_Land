import "package:flutter/material.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";
import "package:hollyday_land/api_server.dart";
import "package:hollyday_land/models/image_upload.dart";
import "package:hollyday_land/providers/login.dart";
import "package:hollyday_land/screens/profile.dart";
import "package:image_picker/image_picker.dart";
import "package:provider/provider.dart";

class WriteComment extends StatelessWidget {
  final int attractionId;

  const WriteComment({Key? key, required this.attractionId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final login = Provider.of<LoginProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Write a comment"),
      ),
      body: login.hdToken == null
          ? ProfileScreen.loginBody(login)
          : _LoggedInWriteComment(
              attractionId: attractionId,
              hdToken: login.hdToken!,
            ),
    );
  }
}

class _LoggedInWriteComment extends StatefulWidget {
  final int attractionId;
  final String hdToken;

  const _LoggedInWriteComment({
    Key? key,
    required this.attractionId,
    required this.hdToken,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoggedInWriteCommentState();
}

class _LoggedInWriteCommentState extends State<_LoggedInWriteComment> {
  double _ratingValue = 0;
  bool _imageUploading = false;
  final List<ImageUpload> _uploadedImages = [];
  final bodyController = TextEditingController();

  void pickImage(ImageSource source) {
    setState(() {
      _imageUploading = true;
    });

    // Pick an image
    ImagePicker()
        .pickImage(
      source: source,
      imageQuality: 80,
      maxWidth: 3840,
      maxHeight: 2160,
    )
        .then((picture) async {
      if (picture != null) {
        final image = await ImageUpload.uploadImage(picture, widget.hdToken);

        setState(() {
          _uploadedImages.add(image);
          _imageUploading = false;
        });
      } else {
        setState(() {
          _imageUploading = false;
        });
      }
    });
  }

  List<Widget> _imagesWrap() {
    List<Widget> result = [];

    _uploadedImages.forEach((image) {
      final thumb = image.thumbs.firstWhere(
        (t) => t.width == 64 || t.height == 64,
      );

      result.add(Image.network(
        thumb.url,
        width: thumb.width.toDouble(),
        height: thumb.height.toDouble(),
      ));
    });

    if (!_imageUploading) {
      result.add(IconButton(
          onPressed: () {
            pickImage(ImageSource.camera);
          },
          icon: Icon(Icons.camera)));
      result.add(IconButton(
          onPressed: () {
            pickImage(ImageSource.gallery);
          },
          icon: Icon(Icons.drive_folder_upload)));
    } else {
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
          ),
          Text("Add images:"),
          Wrap(
            children: _imagesWrap(),
          ),
          TextButton(
            onPressed: () {
              final requestBody = {
                "token": widget.hdToken,
                "attraction_id": widget.attractionId,
                "rating": _ratingValue.toInt(),
                "image_ids":
                    _uploadedImages.map((image) => image.imageId).toList()
              };

              if (bodyController.value.text.trim().isNotEmpty) {
                requestBody["text"] = bodyController.value.text.trim();
              }

              ApiServer.post("attractions/api/comments/attraction",
                      "comment_id", requestBody)
                  .then(
                (value) => Navigator.of(context).pop(value),
              );
            },
            child: Text("Publish comment"),
          ),
        ],
      ),
    );
  }
}
