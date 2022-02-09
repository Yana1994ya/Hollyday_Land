import "dart:async";
import "dart:convert";

import "package:hollyday_land/api_server.dart";
import "package:hollyday_land/models/upload_error.dart";
import "package:http/http.dart" as http;
import "package:image_picker/image_picker.dart";

class ImageUpload {
  static Future<int> uploadImage(XFile file, String hdToken) async {
    http.MultipartRequest request = http.MultipartRequest(
      "POST",
      Uri.https(ApiServer.serverName, "attractions/api/upload_image"),
    );
    request.headers["host"] = ApiServer.serverName;

    /*http.MultipartRequest request = http.MultipartRequest(
      "POST",
      Uri.http("192.168.1.159:8000", "attractions/api/upload_image"),
    );*/

    request.fields["token"] = hdToken;

    request.files.add(await http.MultipartFile.fromPath("image", file.path,
        filename: "image.jpg"));

    final response = await request.send();

    if (response.statusCode == 200) {
      final Completer<int> imageId = Completer();

      response.stream.transform(utf8.decoder).listen((body) {
        final Map<String, dynamic> data = jsonDecode(body);
        imageId.complete(data["image_id"]);
      });

      return imageId.future;
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
