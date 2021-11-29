import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/failure.dart';
import 'package:gravenhorst_adults_app/src/core/globals.dart';
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
  List<Exhibit> exhibits;

  Tours(
      {required this.id,
      required this.name,
      required this.sortOrder,
      required this.description,
      required this.exhibits});
  factory Tours.fromJson(Map<String, dynamic> json) => _$ToursFromJson(json);

  Map<String, dynamic> toJson() => _$ToursToJson(this);
}

@JsonSerializable(
    fieldRename: FieldRename.snake, createToJson: true, explicitToJson: true)
class Exhibit {
  int id;
  int sortOrder;
  String name;
  String latitude;
  String longitude;
  String markerColor;
  String textColor;
  List<Entry> entries;

  Exhibit(
      {required this.id,
      required this.sortOrder,
      required this.name,
      required this.latitude,
      required this.longitude,
      required this.markerColor,
      required this.textColor,
      required this.entries});

  factory Exhibit.fromJson(Map<String, dynamic> json) =>
      _$ExhibitFromJson(json);
  Map<String, dynamic> toJson() => _$ExhibitToJson(this);
}

@JsonSerializable(
    fieldRename: FieldRename.snake, createToJson: true, explicitToJson: true)
class Entry {
  int id;
  int sortOrder;
  String type;
  String title;
  String description;
  Background background;
  List<Asset> assets;

  Entry(
      {required this.id,
      required this.sortOrder,
      required this.type,
      required this.title,
      required this.description,
      required this.background,
      required this.assets});

  factory Entry.fromJson(Map<String, dynamic> json) => _$EntryFromJson(json);
  Map<String, dynamic> toJson() => _$EntryToJson(this);
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

enum AssetType { image, audio, video }

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

  AssetType get assetType {
    if (mimeType.contains('image')) {
      return AssetType.image;
    } else if (mimeType.contains('video')) {
      return AssetType.video;
    } else if (mimeType.contains('audio')) {
      return AssetType.audio;
    } else {
      throw Failure(msg: 'Unsupported Asset Type $mimeType');
    }
  }

  // todo check if .creat(recursive:true) causes problems when you call this function for the sole purpose of retrieveing the file
  Future<File> localFile() async {
    final path = await documentDirectoryPath;
    return File('$path/$assetUrlLocalPath');
  }

  Future<bool> existsInLocalStorage() async {
    final file = await localFile();
    return await file.exists();
  }
}
