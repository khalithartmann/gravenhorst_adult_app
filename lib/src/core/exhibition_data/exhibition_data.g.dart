// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exhibition_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExhibitionData _$ExhibitionDataFromJson(Map<String, dynamic> json) =>
    ExhibitionData(
      id: json['id'] as String,
      localeName: json['locale_name'] as String,
      contentSize: json['content_size'] as int,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      tours: (json['tours'] as List<dynamic>)
          .map((e) => Tours.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExhibitionDataToJson(ExhibitionData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'locale_name': instance.localeName,
      'content_size': instance.contentSize,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'tours': instance.tours,
    };

Tours _$ToursFromJson(Map<String, dynamic> json) => Tours(
      id: json['id'] as int,
      name: json['name'] as String,
      sortOrder: json['sortOrder'] as int?,
      description: json['description'] as String,
      locations: (json['locations'] as List<dynamic>)
          .map((e) => Locations.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ToursToJson(Tours instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sortOrder': instance.sortOrder,
      'description': instance.description,
      'locations': instance.locations,
    };

Locations _$LocationsFromJson(Map<String, dynamic> json) => Locations(
      id: json['id'] as int,
      sortOrder: json['sortOrder'] as int?,
      name: json['name'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
      markerColor: json['markerColor'] as String?,
      textColor: json['textColor'] as String?,
      entries: (json['entries'] as List<dynamic>)
          .map((e) => Entries.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LocationsToJson(Locations instance) => <String, dynamic>{
      'id': instance.id,
      'sortOrder': instance.sortOrder,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'markerColor': instance.markerColor,
      'textColor': instance.textColor,
      'entries': instance.entries,
    };

Entries _$EntriesFromJson(Map<String, dynamic> json) => Entries(
      id: json['id'] as int,
      sortOrder: json['sortOrder'] as int?,
      type: json['type'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      background: json['background'] == null
          ? null
          : Background.fromJson(json['background'] as Map<String, dynamic>),
      assets: (json['assets'] as List<dynamic>)
          .map((e) => Asset.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EntriesToJson(Entries instance) => <String, dynamic>{
      'id': instance.id,
      'sortOrder': instance.sortOrder,
      'type': instance.type,
      'title': instance.title,
      'description': instance.description,
      'background': instance.background,
      'assets': instance.assets,
    };

Background _$BackgroundFromJson(Map<String, dynamic> json) => Background(
      imageAssetId: json['imageAssetId'] as int?,
      color: json['color'] as String,
      size: json['size'] as String,
      position: json['position'] as String,
    );

Map<String, dynamic> _$BackgroundToJson(Background instance) =>
    <String, dynamic>{
      'imageAssetId': instance.imageAssetId,
      'color': instance.color,
      'size': instance.size,
      'position': instance.position,
    };

Asset _$AssetsFromJson(Map<String, dynamic> json) => Asset(
      id: json['id'] as int,
      sortOrder: json['sortOrder'] as int?,
      assetUrl: json['assetUrl'] as String?,
      mimeType: json['mimeType'] as String?,
      description: json['description'] as String,
      title: json['title'] as String,
      copyright: json['copyright'] as String,
      assetSize: json['assetSize'] as int?,
      assetDuration: json['assetDuration'] as int?,
      autoplay: json['autoplay'] as bool,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$AssetsToJson(Asset instance) => <String, dynamic>{
      'id': instance.id,
      'sortOrder': instance.sortOrder,
      'assetUrl': instance.assetUrl,
      'mimeType': instance.mimeType,
      'description': instance.description,
      'title': instance.title,
      'copyright': instance.copyright,
      'assetSize': instance.assetSize,
      'assetDuration': instance.assetDuration,
      'autoplay': instance.autoplay,
      'updatedAt': instance.updatedAt,
    };
