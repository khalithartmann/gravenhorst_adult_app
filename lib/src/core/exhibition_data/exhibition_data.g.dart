// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exhibition_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ExhibitionData _$$_ExhibitionDataFromJson(Map<String, dynamic> json) =>
    _$_ExhibitionData(
      id: json['id'] as String,
      contentSize: json['asset_content_size'] as int,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      tours: (json['tours'] as List<dynamic>)
          .map((e) => Tour.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ExhibitionDataToJson(_$_ExhibitionData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'asset_content_size': instance.contentSize,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'tours': instance.tours.map((e) => e.toJson()).toList(),
    };

_$_Tour _$$_TourFromJson(Map<String, dynamic> json) => _$_Tour(
      id: json['id'] as int,
      name: json['name'] as String,
      sortOrder: json['sort_order'] as int?,
      description: json['description'] as String?,
      exhibits: (json['locations'] as List<dynamic>)
          .map((e) => Exhibit.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_TourToJson(_$_Tour instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sort_order': instance.sortOrder,
      'description': instance.description,
      'locations': instance.exhibits.map((e) => e.toJson()).toList(),
    };

_$_Exhibit _$$_ExhibitFromJson(Map<String, dynamic> json) => _$_Exhibit(
      id: json['id'] as int,
      sortOrder: json['sort_order'] as int?,
      name: json['name'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
      markerColor: json['marker_color'] as String,
      textColor: json['text_color'] as String,
      entries: (json['entries'] as List<dynamic>)
          .map((e) => Entry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ExhibitToJson(_$_Exhibit instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sort_order': instance.sortOrder,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'marker_color': instance.markerColor,
      'text_color': instance.textColor,
      'entries': instance.entries.map((e) => e.toJson()).toList(),
    };

_$_Entry _$$_EntryFromJson(Map<String, dynamic> json) => _$_Entry(
      id: json['id'] as int,
      sortOrder: json['sort_order'] as int?,
      type: json['type'] as String,
      title: json['title'] as String?,
      description: json['description'] as String?,
      background:
          Background.fromJson(json['background'] as Map<String, dynamic>),
      assets: (json['assets'] as List<dynamic>)
          .map((e) => Asset.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_EntryToJson(_$_Entry instance) => <String, dynamic>{
      'id': instance.id,
      'sort_order': instance.sortOrder,
      'type': instance.type,
      'title': instance.title,
      'description': instance.description,
      'background': instance.background.toJson(),
      'assets': instance.assets.map((e) => e.toJson()).toList(),
    };

_$_Background _$$_BackgroundFromJson(Map<String, dynamic> json) =>
    _$_Background(
      imageAssetId: json['image_asset_id'] as int?,
      color: json['color'] as String,
      size: json['size'] as String,
      position: json['position'] as String,
    );

Map<String, dynamic> _$$_BackgroundToJson(_$_Background instance) =>
    <String, dynamic>{
      'image_asset_id': instance.imageAssetId,
      'color': instance.color,
      'size': instance.size,
      'position': instance.position,
    };

_$_Asset _$$_AssetFromJson(Map<String, dynamic> json) => _$_Asset(
      id: json['id'] as int,
      sortOrder: json['sort_order'] as int?,
      size: json['size'] as int,
      url: json['url'] as String,
      mimeType: json['mime_type'] as String,
      duration: (json['duration'] as num?)?.toDouble(),
      autoplay: json['autoplay'] as bool?,
      interactive: json['interactive'] as bool?,
      loop: json['loop'] as bool?,
      description: json['description'] as String? ?? "",
      title: json['title'] as String? ?? "",
      copyright: json['copyright'] as String?,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$$_AssetToJson(_$_Asset instance) => <String, dynamic>{
      'id': instance.id,
      'sort_order': instance.sortOrder,
      'size': instance.size,
      'url': instance.url,
      'mime_type': instance.mimeType,
      'duration': instance.duration,
      'autoplay': instance.autoplay,
      'interactive': instance.interactive,
      'loop': instance.loop,
      'description': instance.description,
      'title': instance.title,
      'copyright': instance.copyright,
      'updated_at': instance.updatedAt,
    };
