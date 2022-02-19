// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MeterRangeCWProxy {
  MeterRange rangeEnd(int? rangeEnd);

  MeterRange rangeStart(int? rangeStart);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MeterRange(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MeterRange(...).copyWith(id: 12, name: "My name")
  /// ````
  MeterRange call({
    int? rangeEnd,
    int? rangeStart,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMeterRange.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMeterRange.copyWith.fieldName(...)`
class _$MeterRangeCWProxyImpl implements _$MeterRangeCWProxy {
  final MeterRange _value;

  const _$MeterRangeCWProxyImpl(this._value);

  @override
  MeterRange rangeEnd(int? rangeEnd) => this(rangeEnd: rangeEnd);

  @override
  MeterRange rangeStart(int? rangeStart) => this(rangeStart: rangeStart);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MeterRange(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MeterRange(...).copyWith(id: 12, name: "My name")
  /// ````
  MeterRange call({
    Object? rangeEnd = const $CopyWithPlaceholder(),
    Object? rangeStart = const $CopyWithPlaceholder(),
  }) {
    return MeterRange(
      rangeEnd: rangeEnd == const $CopyWithPlaceholder()
          ? _value.rangeEnd
          // ignore: cast_nullable_to_non_nullable
          : rangeEnd as int?,
      rangeStart: rangeStart == const $CopyWithPlaceholder()
          ? _value.rangeStart
          // ignore: cast_nullable_to_non_nullable
          : rangeStart as int?,
    );
  }
}

extension $MeterRangeCopyWith on MeterRange {
  /// Returns a callable class that can be used as follows: `instanceOfclass MeterRange.name.copyWith(...)` or like so:`instanceOfclass MeterRange.name.copyWith.fieldName(...)`.
  _$MeterRangeCWProxy get copyWith => _$MeterRangeCWProxyImpl(this);
}

abstract class _$TrailsFilterCWProxy {
  TrailsFilter activities(BuiltSet<int> activities);

  TrailsFilter attractions(BuiltSet<int> attractions);

  TrailsFilter difficulty(BuiltSet<Difficulty> difficulty);

  TrailsFilter elevationGain(MeterRange elevationGain);

  TrailsFilter length(MeterRange length);

  TrailsFilter suitabilities(BuiltSet<int> suitabilities);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TrailsFilter(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TrailsFilter(...).copyWith(id: 12, name: "My name")
  /// ````
  TrailsFilter call({
    BuiltSet<int>? activities,
    BuiltSet<int>? attractions,
    BuiltSet<Difficulty>? difficulty,
    MeterRange? elevationGain,
    MeterRange? length,
    BuiltSet<int>? suitabilities,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTrailsFilter.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTrailsFilter.copyWith.fieldName(...)`
class _$TrailsFilterCWProxyImpl implements _$TrailsFilterCWProxy {
  final TrailsFilter _value;

  const _$TrailsFilterCWProxyImpl(this._value);

  @override
  TrailsFilter activities(BuiltSet<int> activities) =>
      this(activities: activities);

  @override
  TrailsFilter attractions(BuiltSet<int> attractions) =>
      this(attractions: attractions);

  @override
  TrailsFilter difficulty(BuiltSet<Difficulty> difficulty) =>
      this(difficulty: difficulty);

  @override
  TrailsFilter elevationGain(MeterRange elevationGain) =>
      this(elevationGain: elevationGain);

  @override
  TrailsFilter length(MeterRange length) => this(length: length);

  @override
  TrailsFilter suitabilities(BuiltSet<int> suitabilities) =>
      this(suitabilities: suitabilities);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TrailsFilter(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TrailsFilter(...).copyWith(id: 12, name: "My name")
  /// ````
  TrailsFilter call({
    Object? activities = const $CopyWithPlaceholder(),
    Object? attractions = const $CopyWithPlaceholder(),
    Object? difficulty = const $CopyWithPlaceholder(),
    Object? elevationGain = const $CopyWithPlaceholder(),
    Object? length = const $CopyWithPlaceholder(),
    Object? suitabilities = const $CopyWithPlaceholder(),
  }) {
    return TrailsFilter(
      activities:
          activities == const $CopyWithPlaceholder() || activities == null
              ? _value.activities
              // ignore: cast_nullable_to_non_nullable
              : activities as BuiltSet<int>,
      attractions:
          attractions == const $CopyWithPlaceholder() || attractions == null
              ? _value.attractions
              // ignore: cast_nullable_to_non_nullable
              : attractions as BuiltSet<int>,
      difficulty:
          difficulty == const $CopyWithPlaceholder() || difficulty == null
              ? _value.difficulty
              // ignore: cast_nullable_to_non_nullable
              : difficulty as BuiltSet<Difficulty>,
      elevationGain:
          elevationGain == const $CopyWithPlaceholder() || elevationGain == null
              ? _value.elevationGain
              // ignore: cast_nullable_to_non_nullable
              : elevationGain as MeterRange,
      length: length == const $CopyWithPlaceholder() || length == null
          ? _value.length
          // ignore: cast_nullable_to_non_nullable
          : length as MeterRange,
      suitabilities:
          suitabilities == const $CopyWithPlaceholder() || suitabilities == null
              ? _value.suitabilities
              // ignore: cast_nullable_to_non_nullable
              : suitabilities as BuiltSet<int>,
    );
  }
}

extension $TrailsFilterCopyWith on TrailsFilter {
  /// Returns a callable class that can be used as follows: `instanceOfclass TrailsFilter.name.copyWith(...)` or like so:`instanceOfclass TrailsFilter.name.copyWith.fieldName(...)`.
  _$TrailsFilterCWProxy get copyWith => _$TrailsFilterCWProxyImpl(this);
}
