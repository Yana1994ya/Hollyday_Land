import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";

class ImageUploadWidget extends StatelessWidget {
  final void Function() pickingImage;
  final void Function() abort;
  final void Function(XFile) pickedImage;

  const ImageUploadWidget({
    Key? key,
    required this.pickedImage,
    required this.abort,
    required this.pickingImage,
  }) : super(key: key);

  void pickImage(ImageSource source) {
    pickingImage();

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
        pickedImage(picture);
      } else {
        abort();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
  }
}
