// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i5;

import '../api_config.dart' as _i3;
import '../exhibition_data/exhibition_data_controller.dart' as _i7;
import '../exhibition_data/exhibition_data_service.dart' as _i6;
import 'register_modules.dart' as _i8;

const String _dev = 'dev';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.singleton<_i3.ApiConfig>(_i3.DevApiConfig(), registerFor: {_dev});
  gh.factory<_i4.Client>(() => registerModule.httpClient);
  gh.factoryAsync<_i5.SharedPreferences>(() => registerModule.prefs);
  gh.singletonAsync<_i6.ExhibitionService>(() async => _i6.ExhibitionService(
      get<_i3.ApiConfig>(),
      get<_i4.Client>(),
      await get.getAsync<_i5.SharedPreferences>()));
  gh.singletonAsync<_i7.ExhibitoinDataController>(() async =>
      _i7.ExhibitoinDataController(
          await get.getAsync<_i6.ExhibitionService>()));
  return get;
}

class _$RegisterModule extends _i8.RegisterModule {}
