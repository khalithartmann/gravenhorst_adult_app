import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  http.Client get httpClient => http.Client();

  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}
