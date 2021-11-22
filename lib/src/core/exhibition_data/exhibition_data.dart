import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exhibition_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
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
}

@JsonSerializable()
class Tours {
  int id;
  String name;
  int? sortOrder;
  String description;
  List<Locations> locations;

  Tours(
      {required this.id,
      required this.name,
      this.sortOrder,
      required this.description,
      required this.locations});
  factory Tours.fromJson(Map<String, dynamic> json) => _$ToursFromJson(json);
}

@JsonSerializable()
class Locations {
  int id;
  int? sortOrder;
  String name;
  String latitude;
  String longitude;
  String? markerColor;
  String? textColor;
  List<Entries> entries;

  Locations(
      {required this.id,
      this.sortOrder,
      required this.name,
      required this.latitude,
      required this.longitude,
      this.markerColor,
      this.textColor,
      required this.entries});

  factory Locations.fromJson(Map<String, dynamic> json) =>
      _$LocationsFromJson(json);
}

@JsonSerializable()
class Entries {
  int id;
  int? sortOrder;
  String type;
  String title;
  String description;
  Background? background;
  List<Asset> assets;

  Entries(
      {required this.id,
      this.sortOrder,
      required this.type,
      required this.title,
      required this.description,
      this.background,
      required this.assets});

  factory Entries.fromJson(Map<String, dynamic> json) =>
      _$EntriesFromJson(json);
}

@JsonSerializable()
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
}

@JsonSerializable()
class Asset {
  int id;
  int? sortOrder;
  String? assetUrl;
  String? mimeType;
  String description;
  String title;
  String copyright;
  int? assetSize;
  int? assetDuration;
  bool autoplay;
  String? updatedAt;

  Asset(
      {required this.id,
      this.sortOrder,
      this.assetUrl,
      this.mimeType,
      required this.description,
      required this.title,
      required this.copyright,
      this.assetSize,
      this.assetDuration,
      required this.autoplay,
      this.updatedAt});
  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetsFromJson(json);
}
