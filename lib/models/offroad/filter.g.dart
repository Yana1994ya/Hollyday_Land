// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$OffRoadTripFilterCWProxy {
  OffRoadTripFilter regionIds(BuiltSet<int> regionIds);

  OffRoadTripFilter tripTypeIds(BuiltSet<int> tripTypeIds);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OffRoadTripFilter(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OffRoadTripFilter(...).copyWith(id: 12, name: "My name")
  /// ````
  OffRoadTripFilter call({
    BuiltSet<int>? regionIds,
    BuiltSet<int>? tripTypeIds,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfOffRoadTripFilter.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfOffRoadTripFilter.copyWith.fieldName(...)`
class _$OffRoadTripFilterCWProxyImpl implements _$OffRoadTripFilterCWProxy {
  final OffRoadTripFilter _value;

  const _$OffRoadTripFilterCWProxyImpl(this._value);

  @override
  OffRoadTripFilter regionIds(BuiltSet<int> regionIds) =>
      this(regionIds: regionIds);

  @override
  OffRoadTripFilter tripTypeIds(BuiltSet<int> tripTypeIds) =>
      this(tripTypeIds: tripTypeIds);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `OffRoadTripFilter(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// OffRoadTripFilter(...).copyWith(id: 12, name: "My name")
  /// ````
  OffRoadTripFilter call({
    Object? regionIds = const $CopyWithPlaceholder(),
    Object? tripTypeIds = const $CopyWithPlaceholder(),
  }) {
    return OffRoadTripFilter(
      regionIds: regionIds == const $CopyWithPlaceholder() || regionIds == null
          ? _value.regionIds
          // ignore: cast_nullable_to_non_nullable
          : regionIds as BuiltSet<int>,
      tripTypeIds:
          tripTypeIds == const $CopyWithPlaceholder() || tripTypeIds == null
              ? _value.tripTypeIds
              // ignore: cast_nullable_to_non_nullable
              : tripTypeIds as BuiltSet<int>,
    );
  }
}

extension $OffRoadTripFilterCopyWith on OffRoadTripFilter {
  /// Returns a callable class that can be used as follows: `instanceOfclass OffRoadTripFilter extends AttractionFilter.name.copyWith(...)` or like so:`instanceOfclass OffRoadTripFilter extends AttractionFilter.name.copyWith.fieldName(...)`.
  _$OffRoadTripFilterCWProxy get copyWith =>
      _$OffRoadTripFilterCWProxyImpl(this);
}
