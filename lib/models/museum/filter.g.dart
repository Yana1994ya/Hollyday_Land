// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MuseumFilterCWProxy {
  MuseumFilter domainIds(BuiltSet<int> domainIds);

  MuseumFilter regionIds(BuiltSet<int> regionIds);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MuseumFilter(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MuseumFilter(...).copyWith(id: 12, name: "My name")
  /// ````
  MuseumFilter call({
    BuiltSet<int>? domainIds,
    BuiltSet<int>? regionIds,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMuseumFilter.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMuseumFilter.copyWith.fieldName(...)`
class _$MuseumFilterCWProxyImpl implements _$MuseumFilterCWProxy {
  final MuseumFilter _value;

  const _$MuseumFilterCWProxyImpl(this._value);

  @override
  MuseumFilter domainIds(BuiltSet<int> domainIds) => this(domainIds: domainIds);

  @override
  MuseumFilter regionIds(BuiltSet<int> regionIds) => this(regionIds: regionIds);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MuseumFilter(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MuseumFilter(...).copyWith(id: 12, name: "My name")
  /// ````
  MuseumFilter call({
    Object? domainIds = const $CopyWithPlaceholder(),
    Object? regionIds = const $CopyWithPlaceholder(),
  }) {
    return MuseumFilter(
      domainIds: domainIds == const $CopyWithPlaceholder() || domainIds == null
          ? _value.domainIds
          // ignore: cast_nullable_to_non_nullable
          : domainIds as BuiltSet<int>,
      regionIds: regionIds == const $CopyWithPlaceholder() || regionIds == null
          ? _value.regionIds
          // ignore: cast_nullable_to_non_nullable
          : regionIds as BuiltSet<int>,
    );
  }
}

extension $MuseumFilterCopyWith on MuseumFilter {
  /// Returns a callable class that can be used as follows: `instanceOfclass MuseumFilter extends AttractionFilter.name.copyWith(...)` or like so:`instanceOfclass MuseumFilter extends AttractionFilter.name.copyWith.fieldName(...)`.
  _$MuseumFilterCWProxy get copyWith => _$MuseumFilterCWProxyImpl(this);
}
