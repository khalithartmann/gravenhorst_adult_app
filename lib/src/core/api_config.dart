import 'package:injectable/injectable.dart';

abstract class ApiConfig {
  String get baseUrl;
  Uri getSupportedLocalesUri();
}

@Singleton(as: ApiConfig, env: [Environment.dev])
class DevApiConfig implements ApiConfig {
  @override
  String get baseUrl => 'nordleu.de';

  @override
  Uri getSupportedLocalesUri() {
    return Uri.https(baseUrl, '/gravenhorst_cms/api/v1/locales.json');
  }
}
