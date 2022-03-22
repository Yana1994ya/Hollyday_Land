import "package:flutter/material.dart";
import "package:hollyday_land/api_server.dart";
import "package:hollyday_land/models/dao/base_attraction.dart";
import "package:hollyday_land/models/dao/base_attraction_short.dart";
import "package:hollyday_land/models/filter_tag.dart";

abstract class ShortModelAccess<Short extends AttractionShort> {
  const ShortModelAccess();

  @protected
  Short fromJson(Map<String, dynamic> json);

  @protected
  String get modelName;

  List<Short> _mapResponse(dynamic apiResponse) {
    return (apiResponse as List<dynamic>)
        .map((attraction) => fromJson(attraction))
        .toList();
  }

  Future<List<Short>> readAttractions(
    Map<String, Iterable<String>> parameters,
  ) {
    return ApiServer.get(
      "/attractions/api/$modelName",
      modelName,
      parameters,
    ).then(_mapResponse);
  }

  Future<List<Short>> readHistory(String token) {
    return ApiServer.post(
      "/attractions/api/history/$modelName",
      modelName,
      {"token": token},
    ).then(_mapResponse);
  }

  Future<List<Short>> readFavorites(
    String token,
    int cacheKey,
  ) {
    return ApiServer.post(
      "/attractions/api/favorites/$modelName",
      modelName,
      {
        "token": token,
        "cache_key": cacheKey,
      },
    ).then(_mapResponse);
  }
}

abstract class AttractionModelAccess<Full extends Attraction> {
  const AttractionModelAccess();

  @protected
  Full fromJson(Map<String, dynamic> json);

  @protected
  String get pluralName;

  @protected
  String get singularName => pluralName;

  Future<Full> read(
    int attractionId,
    int ratingCacheKey,
  ) {
    return ApiServer.get(
      "/attractions/api/$pluralName/$attractionId",
      singularName,
      {
        "rating_cache_key": [ratingCacheKey.toString()]
      },
    ).then((data) => fromJson(data));
  }
}

abstract class FilterTagModelAccess<Tag extends FilterTag> {
  const FilterTagModelAccess();

  @protected
  Tag fromJson(Map<String, dynamic> json);

  @protected
  String get modelName;

  List<Tag> _mapResponse(dynamic apiResponse) {
    return (apiResponse as List<dynamic>)
        .map((attraction) => fromJson(attraction))
        .toList();
  }

  Future<List<Tag>> readTags() async {
    return ApiServer.get(
      "/attractions/api/$modelName",
      modelName,
    ).then(_mapResponse);
  }
}
