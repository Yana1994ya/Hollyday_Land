class ImageAsset {
  final String url;
  final int width;
  final int height;
  final int size;
  final ImageAsset? parent;

  const ImageAsset({
    required this.url,
    required this.width,
    required this.height,
    required this.size,
    required this.parent,
  });

  factory ImageAsset.fromJson(Map<String, dynamic> json) {
    return ImageAsset(
      url: json["url"],
      width: json["width"],
      height: json["height"],
      size: json["size"],
      parent:
          json["parent"] == null ? null : ImageAsset.fromJson(json["parent"]),
    );
  }

  @override
  String toString() {
    return "ImageAsset{url: $url, width: $width, height: $height, size: $size}";
  }
}
