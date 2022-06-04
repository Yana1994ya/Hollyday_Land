// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TourFilterCWProxy {
  TourFilter destinationIds(BuiltSet<int> destinationIds);

  TourFilter packageIds(BuiltSet<int> packageIds);

  TourFilter tourLanguageIds(BuiltSet<int> tourLanguageIds);

  TourFilter tourTypeIds(BuiltSet<int> tourTypeIds);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TourFilter(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TourFilter(...).copyWith(id: 12, name: "My name")
  /// ````
  TourFilter call({
    BuiltSet<int>? destinationIds,
    BuiltSet<int>? packageIds,
    BuiltSet<int>? tourLanguageIds,
    BuiltSet<int>? tourTypeIds,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTourFilter.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTourFilter.copyWith.fieldName(...)`
class _$TourFilterCWProxyImpl implements _$TourFilterCWProxy {
  final TourFilter _value;

  const _$TourFilterCWProxyImpl(this._value);

  @override
  TourFilter destinationIds(BuiltSet<int> destinationIds) =>
      this(destinationIds: destinationIds);

  @override
  TourFilter packageIds(BuiltSet<int> packageIds) =>
      this(packageIds: packageIds);

  @override
  TourFilter tourLanguageIds(BuiltSet<int> tourLanguageIds) =>
      this(tourLanguageIds: tourLanguageIds);

  @override
  TourFilter tourTypeIds(BuiltSet<int> tourTypeIds) =>
      this(tourTypeIds: tourTypeIds);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TourFilter(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TourFilter(...).copyWith(id: 12, name: "My name")
  /// ````
  TourFilter call({
    Object? destinationIds = const $CopyWithPlaceholder(),
    Object? packageIds = const $CopyWithPlaceholder(),
    Object? tourLanguageIds = const $CopyWithPlaceholder(),
    Object? tourTypeIds = const $CopyWithPlaceholder(),
  }) {
    return TourFilter(
      destinationIds: destinationIds == const $CopyWithPlaceholder() ||
              destinationIds == null
          ? _value.destinationIds
          // ignore: cast_nullable_to_non_nullable
          : destinationIds as BuiltSet<int>,
      packageIds:
          packageIds == const $CopyWithPlaceholder() || packageIds == null
              ? _value.packageIds
              // ignore: cast_nullable_to_non_nullable
              : packageIds as BuiltSet<int>,
      tourLanguageIds: tourLanguageIds == const $CopyWithPlaceholder() ||
              tourLanguageIds == null
          ? _value.tourLanguageIds
          // ignore: cast_nullable_to_non_nullable
          : tourLanguageIds as BuiltSet<int>,
      tourTypeIds:
          tourTypeIds == const $CopyWithPlaceholder() || tourTypeIds == null
              ? _value.tourTypeIds
              // ignore: cast_nullable_to_non_nullable
              : tourTypeIds as BuiltSet<int>,
    );
  }
}

extension $TourFilterCopyWith on TourFilter {
  /// Returns a callable class that can be used as follows: `instanceOfclass TourFilter extends AttractionFilter.name.copyWith(...)` or like so:`instanceOfclass TourFilter extends AttractionFilter.name.copyWith.fieldName(...)`.
  _$TourFilterCWProxy get copyWith => _$TourFilterCWProxyImpl(this);
}
