import 'package:injectable/injectable.dart';

abstract class ApiConfig {
  String get baseUrl;
  Uri getSupportedLocalesUri();
  Uri getTourDataForLocaleUri({
    required String localeId,
    required String resolution,
  });
}

@Singleton(as: ApiConfig, env: [Environment.dev])
class DevApiConfig implements ApiConfig {
  @override
  String get baseUrl => 'nordleudi.de';

  @override
  Uri getSupportedLocalesUri() {
    return Uri.https(baseUrl, '/api/v1/locales');
  }

  @override
  Uri getTourDataForLocaleUri(
      {required String localeId, required String resolution}) {
    return Uri.https(baseUrl, '/api/v1/locales/$localeId', {
      "resolution": resolution,
    });
  }
}
