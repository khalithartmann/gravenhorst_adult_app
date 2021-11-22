import 'package:json_annotation/json_annotation.dart';
part 'exhibition_locale.g.dart';

@JsonSerializable()
class ExhibitionLocale {
  ExhibitionLocale({required this.id, required this.name});
  final String id;
  final String name;

  factory ExhibitionLocale.fromJson(Map<String, dynamic> json) {
    return _$ExhibitionLocaleFromJson(json);
  }
}
