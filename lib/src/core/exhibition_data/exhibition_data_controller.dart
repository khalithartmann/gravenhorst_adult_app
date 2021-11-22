import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data_service.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_locale.dart';
import 'package:gravenhorst_adults_app/src/core/failure.dart';
import 'package:gravenhorst_adults_app/src/core/globals.dart';
import 'package:injectable/injectable.dart';

enum ExhibitoinDataControllerState { intial, loading, ready }

@singleton
class ExhibitoinDataController extends ChangeNotifier {
  ExhibitoinDataController(this._exhibitionService);

  var _state = ExhibitoinDataControllerState.intial;
  ExhibitoinDataControllerState get state => _state;

  final ExhibitionService _exhibitionService;
  late Either<Failure, List<ExhibitionLocale>> _eitherFailureOrSupportedLocales;
  Either<Failure, List<ExhibitionLocale>> get failureOrSupportedLocales =>
      _eitherFailureOrSupportedLocales;

  ExhibitionLocale? _currentLocale;
  ExhibitionLocale? get currentLocale => _currentLocale;
  bool get localeSelected => currentLocale != null;

  void getSupportedLocales() async {
    _state = ExhibitoinDataControllerState.loading;
    notifyListeners();

    _eitherFailureOrSupportedLocales =
        await _exhibitionService.fetchSupportedLocales();
    _state = ExhibitoinDataControllerState.ready;
    notifyListeners();
    logger.v(
        '[getSupportedLocales] supported Locales are: $_eitherFailureOrSupportedLocales ');
  }
}
