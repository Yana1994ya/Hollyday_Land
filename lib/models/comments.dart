import "package:hollyday_land/api_server.dart";
import "package:hollyday_land/models/google_user.dart";
import "package:hollyday_land/models/image_asset.dart";

class Comment {
  final int id;
  final GoogleUser user;
  final int rating;
  final String? text;
  final DateTime created;
  final List<ImageAsset> images;

  const Comment({
    required this.id,
    required this.user,
    required this.rating,
    required this.text,
    required this.created,
    required this.images,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    final List<dynamic> imagesJson = json["images"];

    return Comment(
        id: json["id"],
        user: GoogleUser.fromJson(json["user"]),
        rating: json["rating"],
        text: json["text"],
        created: DateTime.parse(json["created"] + "+00:00"),
        images: imagesJson.map((image) => ImageAsset.fromJson(image)).toList());
  }
}

class Comments {
  final int pages;
  final int page;
  final List<Comment> comments;

  factory Comments.fromJson(Map<String, dynamic> json) {
    final List<dynamic> commentsJson = json["items"];

    return Comments(
        pages: json["pages"],
        page: json["page"],
        comments:
            commentsJson.map((comment) => Comment.fromJson(comment)).toList());
  }

  const Comments({
    required this.pages,
    required this.page,
    required this.comments,
  });

  static Future<Comments> readAttractionComments(
    int attractionId,
    int page,
    int cacheKey,
  ) {
    return ApiServer.get(
      "/attractions/api/comments/attraction/$attractionId/$page",
      "comments",
      {
        "cache_key": [cacheKey.toString()]
      },
    ).then((comments) => Comments.fromJson(comments));
  }
}

class NewReview {
  final int rating;
  final String text;
  final List<int> imageIds;
  final String hdToken;

  const NewReview({
    required this.rating,
    required this.text,
    required this.imageIds,
    required this.hdToken,
  });
}
