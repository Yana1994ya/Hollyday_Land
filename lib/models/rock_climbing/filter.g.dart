// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RockClimbingFilterCWProxy {
  RockClimbingFilter attractionTypeIds(BuiltSet<int> attractionTypeIds);

  RockClimbingFilter regionIds(BuiltSet<int> regionIds);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RockClimbingFilter(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RockClimbingFilter(...).copyWith(id: 12, name: "My name")
  /// ````
  RockClimbingFilter call({
    BuiltSet<int>? attractionTypeIds,
    BuiltSet<int>? regionIds,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRockClimbingFilter.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRockClimbingFilter.copyWith.fieldName(...)`
class _$RockClimbingFilterCWProxyImpl implements _$RockClimbingFilterCWProxy {
  final RockClimbingFilter _value;

  const _$RockClimbingFilterCWProxyImpl(this._value);

  @override
  RockClimbingFilter attractionTypeIds(BuiltSet<int> attractionTypeIds) =>
      this(attractionTypeIds: attractionTypeIds);

  @override
  RockClimbingFilter regionIds(BuiltSet<int> regionIds) =>
      this(regionIds: regionIds);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RockClimbingFilter(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RockClimbingFilter(...).copyWith(id: 12, name: "My name")
  /// ````
  RockClimbingFilter call({
    Object? attractionTypeIds = const $CopyWithPlaceholder(),
    Object? regionIds = const $CopyWithPlaceholder(),
  }) {
    return RockClimbingFilter(
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

extension $RockClimbingFilterCopyWith on RockClimbingFilter {
  /// Returns a callable class that can be used as follows: `instanceOfclass RockClimbingFilter extends AttractionFilter.name.copyWith(...)` or like so:`instanceOfclass RockClimbingFilter extends AttractionFilter.name.copyWith.fieldName(...)`.
  _$RockClimbingFilterCWProxy get copyWith =>
      _$RockClimbingFilterCWProxyImpl(this);
}
