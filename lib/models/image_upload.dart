import "dart:async";
import "dart:convert";

import "package:built_collection/built_collection.dart";
import "package:hollyday_land/api_server.dart";
import "package:hollyday_land/models/image_asset.dart";
import "package:hollyday_land/models/upload_error.dart";
import "package:http/http.dart" as http;
import "package:image_picker/image_picker.dart";

class ImageUpload {
  final int imageId;
  final BuiltList<ImageAsset> thumbs;

  const ImageUpload({
    required this.imageId,
    required this.thumbs,
  });

  factory ImageUpload.fromJson(Map<String, dynamic> json) {
    final List<dynamic> thumbsJson = json["thumbs"];

    return ImageUpload(
      imageId: json["image_id"],
      thumbs: BuiltList(thumbsJson.map((m) => ImageAsset.fromJson(m))),
    );
  }

  static Future<http.MultipartRequest> _buildRequest(
    XFile file,
    String hdToken,
  ) async {
    http.MultipartRequest request = http.MultipartRequest(
      "POST",
      ApiServer.getUri("/attractions/api/upload_image"),
    );
    request.headers["host"] = ApiServer.serverName;

    /*http.MultipartRequest request = http.MultipartRequest(
      "POST",
      Uri.http("192.168.1.122:8000", "attractions/api/upload_image"),
    );*/

    request.fields["token"] = hdToken;

    request.files.add(await http.MultipartFile.fromPath("image", file.path,
        filename: "image.jpg"));

    return request;
  }

  static Future<void> uploadTrailImage(
    XFile file,
    String hdToken,
    int trailId,
  ) async {
    final request = await _buildRequest(file, hdToken);
    request.fields["trail_id"] = trailId.toString();

    final response = await request.send();

    if (response.statusCode != 200) {
      final Completer<UploadError> result = Completer();

      response.stream.transform(utf8.decoder).listen((body) {
        result.complete(UploadError(response.statusCode, body));
      });

      UploadError error = await result.future;
      throw error;
    }
  }

  static Future<ImageUpload> uploadImage(
    XFile file,
    String hdToken,
  ) async {
    final request = await _buildRequest(file, hdToken);

    final response = await request.send();

    if (response.statusCode == 200) {
      // Reading the image_id from the result can only happen in an async
      // manner, in a way that doesn't allow me to "await" the result.

      // That's why I'm using Completer to wait for that async process to update
      // me when the id is ready in a future.
      final Completer<ImageUpload> image = Completer();

      response.stream.transform(utf8.decoder).listen((body) {
        final Map<String, dynamic> data = jsonDecode(body);

        image.complete(ImageUpload.fromJson(data["image"]));
      });

      return image.future;
    } else {
      final Completer<UploadError> result = Completer();

      response.stream.transform(utf8.decoder).listen((body) {
        result.complete(UploadError(response.statusCode, body));
      });

      UploadError error = await result.future;
      throw error;
    }
  }
}
