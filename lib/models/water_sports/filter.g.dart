// GENERATED CODE - DO NOT MODIFY BY HAND

part of "filter.dart";

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WaterSportsFilterCWProxy {
  WaterSportsFilter attractionTypeIds(BuiltSet<int> attractionTypeIds);

  WaterSportsFilter regionIds(BuiltSet<int> regionIds);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WaterSportsFilter(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WaterSportsFilter(...).copyWith(id: 12, name: "My name")
  /// ````
  WaterSportsFilter call({
    BuiltSet<int>? attractionTypeIds,
    BuiltSet<int>? regionIds,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfWaterSportsFilter.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfWaterSportsFilter.copyWith.fieldName(...)`
class _$WaterSportsFilterCWProxyImpl implements _$WaterSportsFilterCWProxy {
  final WaterSportsFilter _value;

  const _$WaterSportsFilterCWProxyImpl(this._value);

  @override
  WaterSportsFilter attractionTypeIds(BuiltSet<int> attractionTypeIds) =>
      this(attractionTypeIds: attractionTypeIds);

  @override
  WaterSportsFilter regionIds(BuiltSet<int> regionIds) =>
      this(regionIds: regionIds);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `WaterSportsFilter(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// WaterSportsFilter(...).copyWith(id: 12, name: "My name")
  /// ````
  WaterSportsFilter call({
    Object? attractionTypeIds = const $CopyWithPlaceholder(),
    Object? regionIds = const $CopyWithPlaceholder(),
  }) {
    return WaterSportsFilter(
      attractionTypeIds: attractionTypeIds == const $CopyWithPlaceholder() ||
              attractionTypeIds == null
          ? _value.attractionTypeIds
          // ignore: cast_nullable_to_non_nullable
          : attractionTypeIds as BuiltSet<int>,
      regionIds: regionIds == const $CopyWithPlaceholder() || regionIds == null
          ? _value.regionIds
          // ignore: cast_nullable_to_non_nullable
          : regionIds as BuiltSet<int>,
    );
  }
}

extension $WaterSportsFilterCopyWith on WaterSportsFilter {
  /// Returns a callable class that can be used as follows: `instanceOfclass WaterSportsFilter extends AttractionFilter.name.copyWith(...)` or like so:`instanceOfclass WaterSportsFilter extends AttractionFilter.name.copyWith.fieldName(...)`.
  _$WaterSportsFilterCWProxy get copyWith =>
      _$WaterSportsFilterCWProxyImpl(this);
}
