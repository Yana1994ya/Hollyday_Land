// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExtremeSportsFilterCWProxy {
  ExtremeSportsFilter regionIds(BuiltSet<int> regionIds);

  ExtremeSportsFilter typeIds(BuiltSet<int> typeIds);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExtremeSportsFilter(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExtremeSportsFilter(...).copyWith(id: 12, name: "My name")
  /// ````
  ExtremeSportsFilter call({
    BuiltSet<int>? regionIds,
    BuiltSet<int>? typeIds,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExtremeSportsFilter.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfExtremeSportsFilter.copyWith.fieldName(...)`
class _$ExtremeSportsFilterCWProxyImpl implements _$ExtremeSportsFilterCWProxy {
  final ExtremeSportsFilter _value;

  const _$ExtremeSportsFilterCWProxyImpl(this._value);

  @override
  ExtremeSportsFilter regionIds(BuiltSet<int> regionIds) =>
      this(regionIds: regionIds);

  @override
  ExtremeSportsFilter typeIds(BuiltSet<int> typeIds) => this(typeIds: typeIds);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExtremeSportsFilter(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExtremeSportsFilter(...).copyWith(id: 12, name: "My name")
  /// ````
  ExtremeSportsFilter call({
    Object? regionIds = const $CopyWithPlaceholder(),
    Object? typeIds = const $CopyWithPlaceholder(),
  }) {
    return ExtremeSportsFilter(
      regionIds: regionIds == const $CopyWithPlaceholder() || regionIds == null
          ? _value.regionIds
          // ignore: cast_nullable_to_non_nullable
          : regionIds as BuiltSet<int>,
      typeIds: typeIds == const $CopyWithPlaceholder() || typeIds == null
          ? _value.typeIds
          // ignore: cast_nullable_to_non_nullable
          : typeIds as BuiltSet<int>,
    );
  }
}

extension $ExtremeSportsFilterCopyWith on ExtremeSportsFilter {
  /// Returns a callable class that can be used as follows: `instanceOfclass ExtremeSportsFilter extends AttractionFilter.name.copyWith(...)` or like so:`instanceOfclass ExtremeSportsFilter extends AttractionFilter.name.copyWith.fieldName(...)`.
  _$ExtremeSportsFilterCWProxy get copyWith =>
      _$ExtremeSportsFilterCWProxyImpl(this);
}
