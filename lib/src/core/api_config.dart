import 'package:injectable/injectable.dart';

abstract class ApiConfig {
  String get baseUrl;
  Uri getSupportedLocalesUri();
  Uri getTourDataForLocale({required String localeId});
}

@Singleton(as: ApiConfig, env: [Environment.dev])
class DevApiConfig implements ApiConfig {
  @override
  String get baseUrl => 'nordleu.de';

  @override
  Uri getSupportedLocalesUri() {
    return Uri.https(baseUrl, '/gravenhorst_cms/api/v1/locales.json');
  }

  @override
  Uri getTourDataForLocale({required String localeId}) {
    return Uri.https(baseUrl, '/gravenhorst_cms/api/v1/locales/$localeId.json');
  }
}
