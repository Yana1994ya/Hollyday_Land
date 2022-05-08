// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TourFilterCWProxy {
  TourFilter overnightIds(BuiltSet<int> overnightIds);

  TourFilter packageIds(BuiltSet<int> packageIds);

  TourFilter startLocationIds(BuiltSet<int> startLocationIds);

  TourFilter tourDestinationIds(BuiltSet<int> tourDestinationIds);

  TourFilter tourLanguageIds(BuiltSet<int> tourLanguageIds);

  TourFilter tourThemeIds(BuiltSet<int> tourThemeIds);

  TourFilter tourTypeIds(BuiltSet<int> tourTypeIds);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TourFilter(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TourFilter(...).copyWith(id: 12, name: "My name")
  /// ````
  TourFilter call({
    BuiltSet<int>? overnightIds,
    BuiltSet<int>? packageIds,
    BuiltSet<int>? startLocationIds,
    BuiltSet<int>? tourDestinationIds,
    BuiltSet<int>? tourLanguageIds,
    BuiltSet<int>? tourThemeIds,
    BuiltSet<int>? tourTypeIds,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTourFilter.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTourFilter.copyWith.fieldName(...)`
class _$TourFilterCWProxyImpl implements _$TourFilterCWProxy {
  final TourFilter _value;

  const _$TourFilterCWProxyImpl(this._value);

  @override
  TourFilter overnightIds(BuiltSet<int> overnightIds) =>
      this(overnightIds: overnightIds);

  @override
  TourFilter packageIds(BuiltSet<int> packageIds) =>
      this(packageIds: packageIds);

  @override
  TourFilter startLocationIds(BuiltSet<int> startLocationIds) =>
      this(startLocationIds: startLocationIds);

  @override
  TourFilter tourDestinationIds(BuiltSet<int> tourDestinationIds) =>
      this(tourDestinationIds: tourDestinationIds);

  @override
  TourFilter tourLanguageIds(BuiltSet<int> tourLanguageIds) =>
      this(tourLanguageIds: tourLanguageIds);

  @override
  TourFilter tourThemeIds(BuiltSet<int> tourThemeIds) =>
      this(tourThemeIds: tourThemeIds);

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
    Object? overnightIds = const $CopyWithPlaceholder(),
    Object? packageIds = const $CopyWithPlaceholder(),
    Object? startLocationIds = const $CopyWithPlaceholder(),
    Object? tourDestinationIds = const $CopyWithPlaceholder(),
    Object? tourLanguageIds = const $CopyWithPlaceholder(),
    Object? tourThemeIds = const $CopyWithPlaceholder(),
    Object? tourTypeIds = const $CopyWithPlaceholder(),
  }) {
    return TourFilter(
      overnightIds:
          overnightIds == const $CopyWithPlaceholder() || overnightIds == null
              ? _value.overnightIds
              // ignore: cast_nullable_to_non_nullable
              : overnightIds as BuiltSet<int>,
      packageIds:
          packageIds == const $CopyWithPlaceholder() || packageIds == null
              ? _value.packageIds
              // ignore: cast_nullable_to_non_nullable
              : packageIds as BuiltSet<int>,
      startLocationIds: startLocationIds == const $CopyWithPlaceholder() ||
              startLocationIds == null
          ? _value.startLocationIds
          // ignore: cast_nullable_to_non_nullable
          : startLocationIds as BuiltSet<int>,
      tourDestinationIds: tourDestinationIds == const $CopyWithPlaceholder() ||
              tourDestinationIds == null
          ? _value.tourDestinationIds
          // ignore: cast_nullable_to_non_nullable
          : tourDestinationIds as BuiltSet<int>,
      tourLanguageIds: tourLanguageIds == const $CopyWithPlaceholder() ||
              tourLanguageIds == null
          ? _value.tourLanguageIds
          // ignore: cast_nullable_to_non_nullable
          : tourLanguageIds as BuiltSet<int>,
      tourThemeIds:
          tourThemeIds == const $CopyWithPlaceholder() || tourThemeIds == null
              ? _value.tourThemeIds
              // ignore: cast_nullable_to_non_nullable
              : tourThemeIds as BuiltSet<int>,
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
