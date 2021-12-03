import 'package:injectable/injectable.dart';

abstract class ApiConfig {
  String get baseUrl;
  Uri getSupportedLocalesUri();
  Uri getTourDataForLocaleUri({required String localeId});
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
  Uri getTourDataForLocaleUri({required String localeId}) {
    print('im here');
    return Uri.parse(
        'https://raw.githubusercontent.com/fg-hh/gh_test-data/main/api/v1/locales/$localeId.json');
  }
}
