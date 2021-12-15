import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gravenhorst_adults_app/src/core/api_config.dart';
import 'package:gravenhorst_adults_app/src/core/dependency_injection/dependency_injection.dart';
import 'package:gravenhorst_adults_app/src/core/failure.dart';
import 'package:gravenhorst_adults_app/src/core/globals.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exhibition_data.g.dart';
part 'exhibition_data.freezed.dart';

@freezed
class ExhibitionData with _$ExhibitionData {
  const factory ExhibitionData({
    required String id,
    @JsonKey(name: 'asset_content_size') required int contentSize,
    required String createdAt,
    required String updatedAt,
    required List<Tour> tours,
  }) = _ExhibitionData;

  factory ExhibitionData.fromJson(Map<String, dynamic> json) =>
      _$ExhibitionDataFromJson(json);
}

@freezed
class Tour with _$Tour {
  const factory Tour({
    required int id,
    required String name,
    int? sortOrder,
    String? description,
    @JsonKey(name: 'locations') required List<Exhibit> exhibits,
  }) = _Tour;

  factory Tour.fromJson(Map<String, dynamic> json) => _$TourFromJson(json);
}

@freezed
class Exhibit with _$Exhibit {
  const factory Exhibit({
    required int id,
    int? sortOrder,
    required String name,
    required String latitude,
    required String longitude,
    required String markerColor,
    required String textColor,
    required List<Entry> entries,
  }) = _Exhibit;

  factory Exhibit.fromJson(Map<String, dynamic> json) =>
      _$ExhibitFromJson(json);
}

@freezed
class Entry with _$Entry {
  const factory Entry({
    required int id,
    int? sortOrder,
    required String type,
    String? title,
    String? description,
    required Background background,
    required List<Asset> assets,
  }) = _Entry;

  factory Entry.fromJson(Map<String, dynamic> json) => _$EntryFromJson(json);
}

@freezed
class Background with _$Background {
  const factory Background({
    int? imageAssetId,
    required String color,
    required String size,
    required String position,
  }) = _Background;

  factory Background.fromJson(Map<String, dynamic> json) =>
      _$BackgroundFromJson(json);
}

enum AssetType { image, audio, video }

@freezed
class Asset with _$Asset {
  const Asset._();
  const factory Asset({
    required int id,
    int? sortOrder,
    required String url,
    required String mimeType,
    @Default("") String description,
    @Default("") String title,
    String? copyright,
    required int size,
    double? duration,
    bool? autoplay,
    required String updatedAt,
  }) = _Asset;

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);

  String get assetUrlLocalPath {
    var baseUrl = getIt<ApiConfig>().baseUrl;
    return Uri.file('$baseUrl$url').toFilePath();
  }

  String get remoteUrl {
    var baseUrl = getIt<ApiConfig>().baseUrl;
    return Uri.https(baseUrl, url).toString();
  }

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
