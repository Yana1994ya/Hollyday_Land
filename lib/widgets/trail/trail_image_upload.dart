import "package:flutter/material.dart";
import "package:hollyday_land/models/image_upload.dart";
import "package:hollyday_land/models/upload_error.dart";
import "package:hollyday_land/providers/cache_key.dart";
import "package:image_picker/image_picker.dart";
import "package:provider/provider.dart";

class TrailImageUpload extends StatefulWidget {
  final int trailId;
  final String hdToken;

  const TrailImageUpload({
    Key? key,
    required this.trailId,
    required this.hdToken,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TrailImageUploadState();
}

class _TrailImageUploadState extends State<TrailImageUpload> {
  bool uploading = false;

  void pickImage(ImageSource source) {
    setState(() {
      uploading = true;
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
        await ImageUpload.uploadTrailImage(
          picture,
          widget.hdToken,
          widget.trailId,
        );

        setState(() {
          uploading = false;
        });

        // Notify parent it needs to refresh the list of available images
        Provider.of<CacheKey>(context, listen: false).refresh();
      } else {
        setState(() {
          uploading = false;
        });
      }
    }).catchError((error) {
      if (error is UploadError) {
        print(error.status.toString() + ": " + error.cause);
      }

      setState(() {
        uploading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!uploading) {
      return PopupMenuButton(
        onSelected: (index) {
          if (index == 1) {
            pickImage(ImageSource.camera);
          } else if (index == 2) {
            pickImage(ImageSource.gallery);
          }
        },
        itemBuilder: (context) => <PopupMenuEntry<int>>[
          PopupMenuItem<int>(
            value: 1,
            child: Row(
              children: [
                SizedBox(
                  child: Image.asset("assets/graphics/camera.png"),
                  width: 24,
                  height: 24,
                ),
                Text(" Take a picture"),
              ],
            ),
          ),
          PopupMenuItem<int>(
            value: 2,
            child: Row(
              children: [
                SizedBox(
                  child: Image.asset("assets/graphics/photos.png"),
                  width: 24,
                  height: 24,
                ),
                Text(" Upload from gallery"),
              ],
            ),
          ),
        ],
      );
    } else {
      return IconButton(
        icon: Icon(Icons.hourglass_full),
        onPressed: null,
      );
    }
  }
}
