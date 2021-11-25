import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data_service.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_locale.dart';
import 'package:gravenhorst_adults_app/src/core/failure.dart';
import 'package:gravenhorst_adults_app/src/core/globals.dart';
import 'package:injectable/injectable.dart';
import 'package:collection/collection.dart';

enum ExhibitoinDataControllerState {
  intial,
  loadingSupportedLocales,
  downloadingExhibitionData,
  ready
}

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

  ExhibitionData? get exhibitionDataForCurrentLocale {
    return exhibitionDataList.firstWhereOrNull(
        (element) => element.localeName == _currentLocale?.name);
  }

  bool get exhibitionDataIsLoadedForLocale =>
      exhibitionDataForCurrentLocale != null;

  void getSupportedLocales() async {
    _state = ExhibitoinDataControllerState.loadingSupportedLocales;
    notifyListeners();

    _eitherFailureOrSupportedLocales =
        await _exhibitionService.fetchSupportedLocales();
    _state = ExhibitoinDataControllerState.ready;
    notifyListeners();
    logger.v(
        '[getSupportedLocales] supported Locales are: $_eitherFailureOrSupportedLocales ');
  }

  final List<ExhibitionData> _exhibitionDataList = [];
  List<ExhibitionData> get exhibitionDataList => _exhibitionDataList;
  Stream<int>? downloadProgressStream;

  void onLanguageSelected({required ExhibitionLocale locale}) async {
    _state = ExhibitoinDataControllerState.downloadingExhibitionData;
    _currentLocale = locale;
    notifyListeners();

    var exhibitionDataProgressTupelStream =
        _exhibitionService.fetchExhibitionData(localeId: locale.id);

    downloadProgressStream =
        exhibitionDataProgressTupelStream.map((exhibitoinDataProgressTupel) {
      if (exhibitoinDataProgressTupel.value2 == 100) {
        exhibitionDataList.add(exhibitoinDataProgressTupel.value1!);
        downloadProgressStream = null;
        notifyListeners();
      }
      return exhibitoinDataProgressTupel.value2;
    });

    // _failureOrExhibitionDataList.add(eitherFailureOrExhibitionData);
    _state = ExhibitoinDataControllerState.ready;
    notifyListeners();

    logger.v(
        '[getExhibitionDataForLocale]: loaded exhibition data  $exhibitionDataList');
  }
}
