import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exhibition_data.g.dart';

@JsonSerializable(
    fieldRename: FieldRename.snake, createToJson: true, explicitToJson: true)
class ExhibitionData {
  String id;
  String localeName;
  int contentSize;
  String createdAt;
  String updatedAt;
  List<Tours> tours;

  ExhibitionData(
      {required this.id,
      required this.localeName,
      required this.contentSize,
      required this.createdAt,
      required this.updatedAt,
      required this.tours});

  factory ExhibitionData.fromJson(Map<String, dynamic> json) =>
      _$ExhibitionDataFromJson(json);

  Map<String, dynamic> toJson() => _$ExhibitionDataToJson(this);
}

@JsonSerializable(
    fieldRename: FieldRename.snake, createToJson: true, explicitToJson: true)
class Tours {
  int id;
  String name;
  int sortOrder;
  String description;
  List<Locations> locations;

  Tours(
      {required this.id,
      required this.name,
      required this.sortOrder,
      required this.description,
      required this.locations});
  factory Tours.fromJson(Map<String, dynamic> json) => _$ToursFromJson(json);

  Map<String, dynamic> toJson() => _$ToursToJson(this);
}

@JsonSerializable(
    fieldRename: FieldRename.snake, createToJson: true, explicitToJson: true)
class Locations {
  int id;
  int sortOrder;
  String name;
  String latitude;
  String longitude;
  String markerColor;
  String textColor;
  List<Entries> entries;

  Locations(
      {required this.id,
      required this.sortOrder,
      required this.name,
      required this.latitude,
      required this.longitude,
      required this.markerColor,
      required this.textColor,
      required this.entries});

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);
  Map<String, dynamic> toJson() => _$LocationsToJson(this);
}

@JsonSerializable(
    fieldRename: FieldRename.snake, createToJson: true, explicitToJson: true)
class Entries {
  int id;
  int sortOrder;
  String type;
  String title;
  String description;
  Background background;
  List<Asset> assets;

  Entries(
      {required this.id,
      required this.sortOrder,
      required this.type,
      required this.title,
      required this.description,
      required this.background,
      required this.assets});

  factory Entries.fromJson(Map<String, dynamic> json) =>
      _$EntriesFromJson(json);
  Map<String, dynamic> toJson() => _$EntriesToJson(this);
}

@JsonSerializable(
    fieldRename: FieldRename.snake, createToJson: true, explicitToJson: true)
class Background {
  int? imageAssetId;
  String color;
  String size;
  String position;

  Background(
      {this.imageAssetId,
      required this.color,
      required this.size,
      required this.position});
  factory Background.fromJson(Map<String, dynamic> json) =>
      _$BackgroundFromJson(json);
  Map<String, dynamic> toJson() => _$BackgroundToJson(this);
}

@JsonSerializable(
    fieldRename: FieldRename.snake, createToJson: true, explicitToJson: true)
class Asset {
  int id;
  int sortOrder;
  String assetUrl;
  String mimeType;
  String description;
  String title;
  String copyright;
  int assetSize;
  int assetDuration;
  bool autoplay;
  String updatedAt;

  Asset(
      {required this.id,
      required this.sortOrder,
      required this.assetUrl,
      required this.mimeType,
      required this.description,
      required this.title,
      required this.copyright,
      required this.assetSize,
      required this.assetDuration,
      required this.autoplay,
      required this.updatedAt});
  factory Asset.fromJson(Map<String, dynamic> json) {
    return _$AssetFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AssetToJson(this);

  String get assetUrlLocalPath => assetUrl.replaceFirst('https://', '');
}
