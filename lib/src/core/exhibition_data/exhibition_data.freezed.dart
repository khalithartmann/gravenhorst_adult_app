// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'exhibition_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ExhibitionData _$ExhibitionDataFromJson(Map<String, dynamic> json) {
  return _ExhibitionData.fromJson(json);
}

/// @nodoc
class _$ExhibitionDataTearOff {
  const _$ExhibitionDataTearOff();

  _ExhibitionData call(
      {required String id,
      @JsonKey(name: 'asset_content_size') required int contentSize,
      required String createdAt,
      required String updatedAt,
      required List<Tour> tours}) {
    return _ExhibitionData(
      id: id,
      contentSize: contentSize,
      createdAt: createdAt,
      updatedAt: updatedAt,
      tours: tours,
    );
  }

  ExhibitionData fromJson(Map<String, Object?> json) {
    return ExhibitionData.fromJson(json);
  }
}

/// @nodoc
const $ExhibitionData = _$ExhibitionDataTearOff();

/// @nodoc
mixin _$ExhibitionData {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'asset_content_size')
  int get contentSize => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;
  List<Tour> get tours => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExhibitionDataCopyWith<ExhibitionData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExhibitionDataCopyWith<$Res> {
  factory $ExhibitionDataCopyWith(
          ExhibitionData value, $Res Function(ExhibitionData) then) =
      _$ExhibitionDataCopyWithImpl<$Res>;
  $Res call(
      {String id,
      @JsonKey(name: 'asset_content_size') int contentSize,
      String createdAt,
      String updatedAt,
      List<Tour> tours});
}

/// @nodoc
class _$ExhibitionDataCopyWithImpl<$Res>
    implements $ExhibitionDataCopyWith<$Res> {
  _$ExhibitionDataCopyWithImpl(this._value, this._then);

  final ExhibitionData _value;
  // ignore: unused_field
  final $Res Function(ExhibitionData) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? contentSize = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? tours = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      contentSize: contentSize == freezed
          ? _value.contentSize
          : contentSize // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      tours: tours == freezed
          ? _value.tours
          : tours // ignore: cast_nullable_to_non_nullable
              as List<Tour>,
    ));
  }
}

/// @nodoc
abstract class _$ExhibitionDataCopyWith<$Res>
    implements $ExhibitionDataCopyWith<$Res> {
  factory _$ExhibitionDataCopyWith(
          _ExhibitionData value, $Res Function(_ExhibitionData) then) =
      __$ExhibitionDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      @JsonKey(name: 'asset_content_size') int contentSize,
      String createdAt,
      String updatedAt,
      List<Tour> tours});
}

/// @nodoc
class __$ExhibitionDataCopyWithImpl<$Res>
    extends _$ExhibitionDataCopyWithImpl<$Res>
    implements _$ExhibitionDataCopyWith<$Res> {
  __$ExhibitionDataCopyWithImpl(
      _ExhibitionData _value, $Res Function(_ExhibitionData) _then)
      : super(_value, (v) => _then(v as _ExhibitionData));

  @override
  _ExhibitionData get _value => super._value as _ExhibitionData;

  @override
  $Res call({
    Object? id = freezed,
    Object? contentSize = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? tours = freezed,
  }) {
    return _then(_ExhibitionData(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      contentSize: contentSize == freezed
          ? _value.contentSize
          : contentSize // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      tours: tours == freezed
          ? _value.tours
          : tours // ignore: cast_nullable_to_non_nullable
              as List<Tour>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ExhibitionData implements _ExhibitionData {
  const _$_ExhibitionData(
      {required this.id,
      @JsonKey(name: 'asset_content_size') required this.contentSize,
      required this.createdAt,
      required this.updatedAt,
      required this.tours});

  factory _$_ExhibitionData.fromJson(Map<String, dynamic> json) =>
      _$$_ExhibitionDataFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'asset_content_size')
  final int contentSize;
  @override
  final String createdAt;
  @override
  final String updatedAt;
  @override
  final List<Tour> tours;

  @override
  String toString() {
    return 'ExhibitionData(id: $id, contentSize: $contentSize, createdAt: $createdAt, updatedAt: $updatedAt, tours: $tours)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExhibitionData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.contentSize, contentSize) ||
                other.contentSize == contentSize) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality().equals(other.tours, tours));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, contentSize, createdAt,
      updatedAt, const DeepCollectionEquality().hash(tours));

  @JsonKey(ignore: true)
  @override
  _$ExhibitionDataCopyWith<_ExhibitionData> get copyWith =>
      __$ExhibitionDataCopyWithImpl<_ExhibitionData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExhibitionDataToJson(this);
  }
}

abstract class _ExhibitionData implements ExhibitionData {
  const factory _ExhibitionData(
      {required String id,
      @JsonKey(name: 'asset_content_size') required int contentSize,
      required String createdAt,
      required String updatedAt,
      required List<Tour> tours}) = _$_ExhibitionData;

  factory _ExhibitionData.fromJson(Map<String, dynamic> json) =
      _$_ExhibitionData.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'asset_content_size')
  int get contentSize;
  @override
  String get createdAt;
  @override
  String get updatedAt;
  @override
  List<Tour> get tours;
  @override
  @JsonKey(ignore: true)
  _$ExhibitionDataCopyWith<_ExhibitionData> get copyWith =>
      throw _privateConstructorUsedError;
}

Tour _$TourFromJson(Map<String, dynamic> json) {
  return _Tour.fromJson(json);
}

/// @nodoc
class _$TourTearOff {
  const _$TourTearOff();

  _Tour call(
      {required int id,
      required String name,
      int? sortOrder,
      String? description,
      @JsonKey(name: 'locations') required List<Exhibit> exhibits}) {
    return _Tour(
      id: id,
      name: name,
      sortOrder: sortOrder,
      description: description,
      exhibits: exhibits,
    );
  }

  Tour fromJson(Map<String, Object?> json) {
    return Tour.fromJson(json);
  }
}

/// @nodoc
const $Tour = _$TourTearOff();

/// @nodoc
mixin _$Tour {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int? get sortOrder => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'locations')
  List<Exhibit> get exhibits => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TourCopyWith<Tour> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TourCopyWith<$Res> {
  factory $TourCopyWith(Tour value, $Res Function(Tour) then) =
      _$TourCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String name,
      int? sortOrder,
      String? description,
      @JsonKey(name: 'locations') List<Exhibit> exhibits});
}

/// @nodoc
class _$TourCopyWithImpl<$Res> implements $TourCopyWith<$Res> {
  _$TourCopyWithImpl(this._value, this._then);

  final Tour _value;
  // ignore: unused_field
  final $Res Function(Tour) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? sortOrder = freezed,
    Object? description = freezed,
    Object? exhibits = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sortOrder: sortOrder == freezed
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      exhibits: exhibits == freezed
          ? _value.exhibits
          : exhibits // ignore: cast_nullable_to_non_nullable
              as List<Exhibit>,
    ));
  }
}

/// @nodoc
abstract class _$TourCopyWith<$Res> implements $TourCopyWith<$Res> {
  factory _$TourCopyWith(_Tour value, $Res Function(_Tour) then) =
      __$TourCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String name,
      int? sortOrder,
      String? description,
      @JsonKey(name: 'locations') List<Exhibit> exhibits});
}

/// @nodoc
class __$TourCopyWithImpl<$Res> extends _$TourCopyWithImpl<$Res>
    implements _$TourCopyWith<$Res> {
  __$TourCopyWithImpl(_Tour _value, $Res Function(_Tour) _then)
      : super(_value, (v) => _then(v as _Tour));

  @override
  _Tour get _value => super._value as _Tour;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? sortOrder = freezed,
    Object? description = freezed,
    Object? exhibits = freezed,
  }) {
    return _then(_Tour(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sortOrder: sortOrder == freezed
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      exhibits: exhibits == freezed
          ? _value.exhibits
          : exhibits // ignore: cast_nullable_to_non_nullable
              as List<Exhibit>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Tour implements _Tour {
  const _$_Tour(
      {required this.id,
      required this.name,
      this.sortOrder,
      this.description,
      @JsonKey(name: 'locations') required this.exhibits});

  factory _$_Tour.fromJson(Map<String, dynamic> json) => _$$_TourFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final int? sortOrder;
  @override
  final String? description;
  @override
  @JsonKey(name: 'locations')
  final List<Exhibit> exhibits;

  @override
  String toString() {
    return 'Tour(id: $id, name: $name, sortOrder: $sortOrder, description: $description, exhibits: $exhibits)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Tour &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other.exhibits, exhibits));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, sortOrder, description,
      const DeepCollectionEquality().hash(exhibits));

  @JsonKey(ignore: true)
  @override
  _$TourCopyWith<_Tour> get copyWith =>
      __$TourCopyWithImpl<_Tour>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TourToJson(this);
  }
}

abstract class _Tour implements Tour {
  const factory _Tour(
      {required int id,
      required String name,
      int? sortOrder,
      String? description,
      @JsonKey(name: 'locations') required List<Exhibit> exhibits}) = _$_Tour;

  factory _Tour.fromJson(Map<String, dynamic> json) = _$_Tour.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  int? get sortOrder;
  @override
  String? get description;
  @override
  @JsonKey(name: 'locations')
  List<Exhibit> get exhibits;
  @override
  @JsonKey(ignore: true)
  _$TourCopyWith<_Tour> get copyWith => throw _privateConstructorUsedError;
}

Exhibit _$ExhibitFromJson(Map<String, dynamic> json) {
  return _Exhibit.fromJson(json);
}

/// @nodoc
class _$ExhibitTearOff {
  const _$ExhibitTearOff();

  _Exhibit call(
      {required int id,
      int? sortOrder,
      required String name,
      required String latitude,
      required String longitude,
      required String markerColor,
      required String textColor,
      required List<Entry> entries}) {
    return _Exhibit(
      id: id,
      sortOrder: sortOrder,
      name: name,
      latitude: latitude,
      longitude: longitude,
      markerColor: markerColor,
      textColor: textColor,
      entries: entries,
    );
  }

  Exhibit fromJson(Map<String, Object?> json) {
    return Exhibit.fromJson(json);
  }
}

/// @nodoc
const $Exhibit = _$ExhibitTearOff();

/// @nodoc
mixin _$Exhibit {
  int get id => throw _privateConstructorUsedError;
  int? get sortOrder => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get latitude => throw _privateConstructorUsedError;
  String get longitude => throw _privateConstructorUsedError;
  String get markerColor => throw _privateConstructorUsedError;
  String get textColor => throw _privateConstructorUsedError;
  List<Entry> get entries => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExhibitCopyWith<Exhibit> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExhibitCopyWith<$Res> {
  factory $ExhibitCopyWith(Exhibit value, $Res Function(Exhibit) then) =
      _$ExhibitCopyWithImpl<$Res>;
  $Res call(
      {int id,
      int? sortOrder,
      String name,
      String latitude,
      String longitude,
      String markerColor,
      String textColor,
      List<Entry> entries});
}

/// @nodoc
class _$ExhibitCopyWithImpl<$Res> implements $ExhibitCopyWith<$Res> {
  _$ExhibitCopyWithImpl(this._value, this._then);

  final Exhibit _value;
  // ignore: unused_field
  final $Res Function(Exhibit) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? sortOrder = freezed,
    Object? name = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? markerColor = freezed,
    Object? textColor = freezed,
    Object? entries = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      sortOrder: sortOrder == freezed
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: latitude == freezed
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as String,
      longitude: longitude == freezed
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as String,
      markerColor: markerColor == freezed
          ? _value.markerColor
          : markerColor // ignore: cast_nullable_to_non_nullable
              as String,
      textColor: textColor == freezed
          ? _value.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as String,
      entries: entries == freezed
          ? _value.entries
          : entries // ignore: cast_nullable_to_non_nullable
              as List<Entry>,
    ));
  }
}

/// @nodoc
abstract class _$ExhibitCopyWith<$Res> implements $ExhibitCopyWith<$Res> {
  factory _$ExhibitCopyWith(_Exhibit value, $Res Function(_Exhibit) then) =
      __$ExhibitCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      int? sortOrder,
      String name,
      String latitude,
      String longitude,
      String markerColor,
      String textColor,
      List<Entry> entries});
}

/// @nodoc
class __$ExhibitCopyWithImpl<$Res> extends _$ExhibitCopyWithImpl<$Res>
    implements _$ExhibitCopyWith<$Res> {
  __$ExhibitCopyWithImpl(_Exhibit _value, $Res Function(_Exhibit) _then)
      : super(_value, (v) => _then(v as _Exhibit));

  @override
  _Exhibit get _value => super._value as _Exhibit;

  @override
  $Res call({
    Object? id = freezed,
    Object? sortOrder = freezed,
    Object? name = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? markerColor = freezed,
    Object? textColor = freezed,
    Object? entries = freezed,
  }) {
    return _then(_Exhibit(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      sortOrder: sortOrder == freezed
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: latitude == freezed
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as String,
      longitude: longitude == freezed
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as String,
      markerColor: markerColor == freezed
          ? _value.markerColor
          : markerColor // ignore: cast_nullable_to_non_nullable
              as String,
      textColor: textColor == freezed
          ? _value.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as String,
      entries: entries == freezed
          ? _value.entries
          : entries // ignore: cast_nullable_to_non_nullable
              as List<Entry>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Exhibit implements _Exhibit {
  const _$_Exhibit(
      {required this.id,
      this.sortOrder,
      required this.name,
      required this.latitude,
      required this.longitude,
      required this.markerColor,
      required this.textColor,
      required this.entries});

  factory _$_Exhibit.fromJson(Map<String, dynamic> json) =>
      _$$_ExhibitFromJson(json);

  @override
  final int id;
  @override
  final int? sortOrder;
  @override
  final String name;
  @override
  final String latitude;
  @override
  final String longitude;
  @override
  final String markerColor;
  @override
  final String textColor;
  @override
  final List<Entry> entries;

  @override
  String toString() {
    return 'Exhibit(id: $id, sortOrder: $sortOrder, name: $name, latitude: $latitude, longitude: $longitude, markerColor: $markerColor, textColor: $textColor, entries: $entries)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Exhibit &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.markerColor, markerColor) ||
                other.markerColor == markerColor) &&
            (identical(other.textColor, textColor) ||
                other.textColor == textColor) &&
            const DeepCollectionEquality().equals(other.entries, entries));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      sortOrder,
      name,
      latitude,
      longitude,
      markerColor,
      textColor,
      const DeepCollectionEquality().hash(entries));

  @JsonKey(ignore: true)
  @override
  _$ExhibitCopyWith<_Exhibit> get copyWith =>
      __$ExhibitCopyWithImpl<_Exhibit>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExhibitToJson(this);
  }
}

abstract class _Exhibit implements Exhibit {
  const factory _Exhibit(
      {required int id,
      int? sortOrder,
      required String name,
      required String latitude,
      required String longitude,
      required String markerColor,
      required String textColor,
      required List<Entry> entries}) = _$_Exhibit;

  factory _Exhibit.fromJson(Map<String, dynamic> json) = _$_Exhibit.fromJson;

  @override
  int get id;
  @override
  int? get sortOrder;
  @override
  String get name;
  @override
  String get latitude;
  @override
  String get longitude;
  @override
  String get markerColor;
  @override
  String get textColor;
  @override
  List<Entry> get entries;
  @override
  @JsonKey(ignore: true)
  _$ExhibitCopyWith<_Exhibit> get copyWith =>
      throw _privateConstructorUsedError;
}

Entry _$EntryFromJson(Map<String, dynamic> json) {
  return _Entry.fromJson(json);
}

/// @nodoc
class _$EntryTearOff {
  const _$EntryTearOff();

  _Entry call(
      {required int id,
      int? sortOrder,
      required String type,
      String? title,
      String? description,
      required Background background,
      required List<Asset> assets}) {
    return _Entry(
      id: id,
      sortOrder: sortOrder,
      type: type,
      title: title,
      description: description,
      background: background,
      assets: assets,
    );
  }

  Entry fromJson(Map<String, Object?> json) {
    return Entry.fromJson(json);
  }
}

/// @nodoc
const $Entry = _$EntryTearOff();

/// @nodoc
mixin _$Entry {
  int get id => throw _privateConstructorUsedError;
  int? get sortOrder => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  Background get background => throw _privateConstructorUsedError;
  List<Asset> get assets => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EntryCopyWith<Entry> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EntryCopyWith<$Res> {
  factory $EntryCopyWith(Entry value, $Res Function(Entry) then) =
      _$EntryCopyWithImpl<$Res>;
  $Res call(
      {int id,
      int? sortOrder,
      String type,
      String? title,
      String? description,
      Background background,
      List<Asset> assets});

  $BackgroundCopyWith<$Res> get background;
}

/// @nodoc
class _$EntryCopyWithImpl<$Res> implements $EntryCopyWith<$Res> {
  _$EntryCopyWithImpl(this._value, this._then);

  final Entry _value;
  // ignore: unused_field
  final $Res Function(Entry) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? sortOrder = freezed,
    Object? type = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? background = freezed,
    Object? assets = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      sortOrder: sortOrder == freezed
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int?,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      background: background == freezed
          ? _value.background
          : background // ignore: cast_nullable_to_non_nullable
              as Background,
      assets: assets == freezed
          ? _value.assets
          : assets // ignore: cast_nullable_to_non_nullable
              as List<Asset>,
    ));
  }

  @override
  $BackgroundCopyWith<$Res> get background {
    return $BackgroundCopyWith<$Res>(_value.background, (value) {
      return _then(_value.copyWith(background: value));
    });
  }
}

/// @nodoc
abstract class _$EntryCopyWith<$Res> implements $EntryCopyWith<$Res> {
  factory _$EntryCopyWith(_Entry value, $Res Function(_Entry) then) =
      __$EntryCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      int? sortOrder,
      String type,
      String? title,
      String? description,
      Background background,
      List<Asset> assets});

  @override
  $BackgroundCopyWith<$Res> get background;
}

/// @nodoc
class __$EntryCopyWithImpl<$Res> extends _$EntryCopyWithImpl<$Res>
    implements _$EntryCopyWith<$Res> {
  __$EntryCopyWithImpl(_Entry _value, $Res Function(_Entry) _then)
      : super(_value, (v) => _then(v as _Entry));

  @override
  _Entry get _value => super._value as _Entry;

  @override
  $Res call({
    Object? id = freezed,
    Object? sortOrder = freezed,
    Object? type = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? background = freezed,
    Object? assets = freezed,
  }) {
    return _then(_Entry(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      sortOrder: sortOrder == freezed
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int?,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      background: background == freezed
          ? _value.background
          : background // ignore: cast_nullable_to_non_nullable
              as Background,
      assets: assets == freezed
          ? _value.assets
          : assets // ignore: cast_nullable_to_non_nullable
              as List<Asset>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Entry implements _Entry {
  const _$_Entry(
      {required this.id,
      this.sortOrder,
      required this.type,
      this.title,
      this.description,
      required this.background,
      required this.assets});

  factory _$_Entry.fromJson(Map<String, dynamic> json) =>
      _$$_EntryFromJson(json);

  @override
  final int id;
  @override
  final int? sortOrder;
  @override
  final String type;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final Background background;
  @override
  final List<Asset> assets;

  @override
  String toString() {
    return 'Entry(id: $id, sortOrder: $sortOrder, type: $type, title: $title, description: $description, background: $background, assets: $assets)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Entry &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.background, background) ||
                other.background == background) &&
            const DeepCollectionEquality().equals(other.assets, assets));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, sortOrder, type, title,
      description, background, const DeepCollectionEquality().hash(assets));

  @JsonKey(ignore: true)
  @override
  _$EntryCopyWith<_Entry> get copyWith =>
      __$EntryCopyWithImpl<_Entry>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EntryToJson(this);
  }
}

abstract class _Entry implements Entry {
  const factory _Entry(
      {required int id,
      int? sortOrder,
      required String type,
      String? title,
      String? description,
      required Background background,
      required List<Asset> assets}) = _$_Entry;

  factory _Entry.fromJson(Map<String, dynamic> json) = _$_Entry.fromJson;

  @override
  int get id;
  @override
  int? get sortOrder;
  @override
  String get type;
  @override
  String? get title;
  @override
  String? get description;
  @override
  Background get background;
  @override
  List<Asset> get assets;
  @override
  @JsonKey(ignore: true)
  _$EntryCopyWith<_Entry> get copyWith => throw _privateConstructorUsedError;
}

Background _$BackgroundFromJson(Map<String, dynamic> json) {
  return _Background.fromJson(json);
}

/// @nodoc
class _$BackgroundTearOff {
  const _$BackgroundTearOff();

  _Background call(
      {int? imageAssetId,
      required String color,
      required String size,
      required String position}) {
    return _Background(
      imageAssetId: imageAssetId,
      color: color,
      size: size,
      position: position,
    );
  }

  Background fromJson(Map<String, Object?> json) {
    return Background.fromJson(json);
  }
}

/// @nodoc
const $Background = _$BackgroundTearOff();

/// @nodoc
mixin _$Background {
  int? get imageAssetId => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  String get size => throw _privateConstructorUsedError;
  String get position => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BackgroundCopyWith<Background> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BackgroundCopyWith<$Res> {
  factory $BackgroundCopyWith(
          Background value, $Res Function(Background) then) =
      _$BackgroundCopyWithImpl<$Res>;
  $Res call({int? imageAssetId, String color, String size, String position});
}

/// @nodoc
class _$BackgroundCopyWithImpl<$Res> implements $BackgroundCopyWith<$Res> {
  _$BackgroundCopyWithImpl(this._value, this._then);

  final Background _value;
  // ignore: unused_field
  final $Res Function(Background) _then;

  @override
  $Res call({
    Object? imageAssetId = freezed,
    Object? color = freezed,
    Object? size = freezed,
    Object? position = freezed,
  }) {
    return _then(_value.copyWith(
      imageAssetId: imageAssetId == freezed
          ? _value.imageAssetId
          : imageAssetId // ignore: cast_nullable_to_non_nullable
              as int?,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String,
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$BackgroundCopyWith<$Res> implements $BackgroundCopyWith<$Res> {
  factory _$BackgroundCopyWith(
          _Background value, $Res Function(_Background) then) =
      __$BackgroundCopyWithImpl<$Res>;
  @override
  $Res call({int? imageAssetId, String color, String size, String position});
}

/// @nodoc
class __$BackgroundCopyWithImpl<$Res> extends _$BackgroundCopyWithImpl<$Res>
    implements _$BackgroundCopyWith<$Res> {
  __$BackgroundCopyWithImpl(
      _Background _value, $Res Function(_Background) _then)
      : super(_value, (v) => _then(v as _Background));

  @override
  _Background get _value => super._value as _Background;

  @override
  $Res call({
    Object? imageAssetId = freezed,
    Object? color = freezed,
    Object? size = freezed,
    Object? position = freezed,
  }) {
    return _then(_Background(
      imageAssetId: imageAssetId == freezed
          ? _value.imageAssetId
          : imageAssetId // ignore: cast_nullable_to_non_nullable
              as int?,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String,
      position: position == freezed
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Background implements _Background {
  const _$_Background(
      {this.imageAssetId,
      required this.color,
      required this.size,
      required this.position});

  factory _$_Background.fromJson(Map<String, dynamic> json) =>
      _$$_BackgroundFromJson(json);

  @override
  final int? imageAssetId;
  @override
  final String color;
  @override
  final String size;
  @override
  final String position;

  @override
  String toString() {
    return 'Background(imageAssetId: $imageAssetId, color: $color, size: $size, position: $position)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Background &&
            (identical(other.imageAssetId, imageAssetId) ||
                other.imageAssetId == imageAssetId) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, imageAssetId, color, size, position);

  @JsonKey(ignore: true)
  @override
  _$BackgroundCopyWith<_Background> get copyWith =>
      __$BackgroundCopyWithImpl<_Background>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BackgroundToJson(this);
  }
}

abstract class _Background implements Background {
  const factory _Background(
      {int? imageAssetId,
      required String color,
      required String size,
      required String position}) = _$_Background;

  factory _Background.fromJson(Map<String, dynamic> json) =
      _$_Background.fromJson;

  @override
  int? get imageAssetId;
  @override
  String get color;
  @override
  String get size;
  @override
  String get position;
  @override
  @JsonKey(ignore: true)
  _$BackgroundCopyWith<_Background> get copyWith =>
      throw _privateConstructorUsedError;
}

Asset _$AssetFromJson(Map<String, dynamic> json) {
  return _Asset.fromJson(json);
}

/// @nodoc
class _$AssetTearOff {
  const _$AssetTearOff();

  _Asset call(
      {required int id,
      int? sortOrder,
      required String url,
      required String mimeType,
      String description = "",
      String title = "",
      String? copyright,
      required int size,
      double? duration,
      bool? autoplay,
      required String updatedAt}) {
    return _Asset(
      id: id,
      sortOrder: sortOrder,
      url: url,
      mimeType: mimeType,
      description: description,
      title: title,
      copyright: copyright,
      size: size,
      duration: duration,
      autoplay: autoplay,
      updatedAt: updatedAt,
    );
  }

  Asset fromJson(Map<String, Object?> json) {
    return Asset.fromJson(json);
  }
}

/// @nodoc
const $Asset = _$AssetTearOff();

/// @nodoc
mixin _$Asset {
  int get id => throw _privateConstructorUsedError;
  int? get sortOrder => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get mimeType => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get copyright => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;
  double? get duration => throw _privateConstructorUsedError;
  bool? get autoplay => throw _privateConstructorUsedError;
  String get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AssetCopyWith<Asset> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssetCopyWith<$Res> {
  factory $AssetCopyWith(Asset value, $Res Function(Asset) then) =
      _$AssetCopyWithImpl<$Res>;
  $Res call(
      {int id,
      int? sortOrder,
      String url,
      String mimeType,
      String description,
      String title,
      String? copyright,
      int size,
      double? duration,
      bool? autoplay,
      String updatedAt});
}

/// @nodoc
class _$AssetCopyWithImpl<$Res> implements $AssetCopyWith<$Res> {
  _$AssetCopyWithImpl(this._value, this._then);

  final Asset _value;
  // ignore: unused_field
  final $Res Function(Asset) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? sortOrder = freezed,
    Object? url = freezed,
    Object? mimeType = freezed,
    Object? description = freezed,
    Object? title = freezed,
    Object? copyright = freezed,
    Object? size = freezed,
    Object? duration = freezed,
    Object? autoplay = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      sortOrder: sortOrder == freezed
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int?,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      mimeType: mimeType == freezed
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      copyright: copyright == freezed
          ? _value.copyright
          : copyright // ignore: cast_nullable_to_non_nullable
              as String?,
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double?,
      autoplay: autoplay == freezed
          ? _value.autoplay
          : autoplay // ignore: cast_nullable_to_non_nullable
              as bool?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$AssetCopyWith<$Res> implements $AssetCopyWith<$Res> {
  factory _$AssetCopyWith(_Asset value, $Res Function(_Asset) then) =
      __$AssetCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      int? sortOrder,
      String url,
      String mimeType,
      String description,
      String title,
      String? copyright,
      int size,
      double? duration,
      bool? autoplay,
      String updatedAt});
}

/// @nodoc
class __$AssetCopyWithImpl<$Res> extends _$AssetCopyWithImpl<$Res>
    implements _$AssetCopyWith<$Res> {
  __$AssetCopyWithImpl(_Asset _value, $Res Function(_Asset) _then)
      : super(_value, (v) => _then(v as _Asset));

  @override
  _Asset get _value => super._value as _Asset;

  @override
  $Res call({
    Object? id = freezed,
    Object? sortOrder = freezed,
    Object? url = freezed,
    Object? mimeType = freezed,
    Object? description = freezed,
    Object? title = freezed,
    Object? copyright = freezed,
    Object? size = freezed,
    Object? duration = freezed,
    Object? autoplay = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_Asset(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      sortOrder: sortOrder == freezed
          ? _value.sortOrder
          : sortOrder // ignore: cast_nullable_to_non_nullable
              as int?,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      mimeType: mimeType == freezed
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      copyright: copyright == freezed
          ? _value.copyright
          : copyright // ignore: cast_nullable_to_non_nullable
              as String?,
      size: size == freezed
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as double?,
      autoplay: autoplay == freezed
          ? _value.autoplay
          : autoplay // ignore: cast_nullable_to_non_nullable
              as bool?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Asset extends _Asset {
  const _$_Asset(
      {required this.id,
      this.sortOrder,
      required this.url,
      required this.mimeType,
      this.description = "",
      this.title = "",
      this.copyright,
      required this.size,
      this.duration,
      this.autoplay,
      required this.updatedAt})
      : super._();

  factory _$_Asset.fromJson(Map<String, dynamic> json) =>
      _$$_AssetFromJson(json);

  @override
  final int id;
  @override
  final int? sortOrder;
  @override
  final String url;
  @override
  final String mimeType;
  @JsonKey(defaultValue: "")
  @override
  final String description;
  @JsonKey(defaultValue: "")
  @override
  final String title;
  @override
  final String? copyright;
  @override
  final int size;
  @override
  final double? duration;
  @override
  final bool? autoplay;
  @override
  final String updatedAt;

  @override
  String toString() {
    return 'Asset(id: $id, sortOrder: $sortOrder, url: $url, mimeType: $mimeType, description: $description, title: $title, copyright: $copyright, size: $size, duration: $duration, autoplay: $autoplay, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Asset &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.copyright, copyright) ||
                other.copyright == copyright) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.autoplay, autoplay) ||
                other.autoplay == autoplay) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, sortOrder, url, mimeType,
      description, title, copyright, size, duration, autoplay, updatedAt);

  @JsonKey(ignore: true)
  @override
  _$AssetCopyWith<_Asset> get copyWith =>
      __$AssetCopyWithImpl<_Asset>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AssetToJson(this);
  }
}

abstract class _Asset extends Asset {
  const factory _Asset(
      {required int id,
      int? sortOrder,
      required String url,
      required String mimeType,
      String description,
      String title,
      String? copyright,
      required int size,
      double? duration,
      bool? autoplay,
      required String updatedAt}) = _$_Asset;
  const _Asset._() : super._();

  factory _Asset.fromJson(Map<String, dynamic> json) = _$_Asset.fromJson;

  @override
  int get id;
  @override
  int? get sortOrder;
  @override
  String get url;
  @override
  String get mimeType;
  @override
  String get description;
  @override
  String get title;
  @override
  String? get copyright;
  @override
  int get size;
  @override
  double? get duration;
  @override
  bool? get autoplay;
  @override
  String get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$AssetCopyWith<_Asset> get copyWith => throw _privateConstructorUsedError;
}
