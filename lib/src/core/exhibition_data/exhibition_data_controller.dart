import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data_service.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_locale.dart';
import 'package:gravenhorst_adults_app/src/core/failure.dart';
import 'package:gravenhorst_adults_app/src/core/globals.dart';
import 'package:injectable/injectable.dart';
import 'package:collection/collection.dart';

@singleton
class ExhibitoinDataController extends ChangeNotifier {
  ExhibitoinDataController(this._exhibitionService);

  final ExhibitionService _exhibitionService;

  Either<Failure, List<ExhibitionLocale>>? _eitherFailureOrSupportedLocales;
  Either<Failure, List<ExhibitionLocale>>? get failureOrSupportedLocales =>
      _eitherFailureOrSupportedLocales;
  List<ExhibitionLocale> get supportedLocales {
    return failureOrSupportedLocales?.fold((l) => [], (r) => r) ?? [];
  }

  ExhibitionLocale? _currentLocale;
  set currentLocale(ExhibitionLocale? locale) {
    _currentLocale = locale;
    notifyListeners();
  }

  ExhibitionLocale? get currentLocale => _currentLocale;
  bool get localeSelected => currentLocale != null;

  ExhibitionData? get exhibitionDataForCurrentLocale {
    return exhibitionDataList
        .firstWhereOrNull((element) => element.id == _currentLocale?.id);
  }

  bool get exhibitionDataIsLoadedForLocale =>
      exhibitionDataForCurrentLocale != null;

  bool _isDownloadingData = false;
  bool get isDownloadingData => _isDownloadingData;
  set isDownloadingData(bool value) {
    _isDownloadingData = value;
    notifyListeners();
  }

  bool get isReady =>
      exhibitionDataForCurrentLocale != null && !isDownloadingData;

  void getSupportedLocales() async {
    isDownloadingData = true;

    _eitherFailureOrSupportedLocales =
        await _exhibitionService.fetchSupportedLocales();

    isDownloadingData = false;
    logger.v(
        '[getSupportedLocales] supported Locales are: $_eitherFailureOrSupportedLocales ');
  }

  List<ExhibitionData> _exhibitionDataList = [];
  List<ExhibitionData> get exhibitionDataList => _exhibitionDataList;
  Stream<int>? downloadProgressStream;
  StreamSubscription<int>? downloadProgressStreamSubscription;

  /// This function loads the [ExhibitionData] for the given [locale]
  ///
  /// The function calls [fetchExhibitionData] which returns a stream containing a [Tupel2<ExhibitionData?, int>] of type
  /// the first value of the [Tuple2] is the ExhibitonData which is returned when the second value is equal too 100
  void onLanguageSelected({required ExhibitionLocale locale}) {
    isDownloadingData = true;
    currentLocale = locale;

    var exhibitionDataProgressTupelStream =
        _exhibitionService.fetchExhibitionData(locale: locale);

    downloadProgressStream =
        exhibitionDataProgressTupelStream.map((exhibitionDataProgressTupel) {
      final progress = exhibitionDataProgressTupel.value2;
      final exhibitionData = exhibitionDataProgressTupel.value1;
      bool dataLoaded = progress == 100;

      bool exhibitionDataAlreadyExistsInList = exhibitionDataList
          .where((element) => exhibitionData?.id == element.id)
          .isNotEmpty;

      if (dataLoaded) {
        if (exhibitionDataAlreadyExistsInList) {
          exhibitionDataList
              .removeWhere((element) => element.id == exhibitionData!.id);
        }

        exhibitionDataList.add(exhibitionData!);
        downloadProgressStream = null;
        downloadProgressStreamSubscription?.cancel();
        isDownloadingData = false;
      }
      return exhibitionDataProgressTupel.value2;
    }).asBroadcastStream();

    logger.v(
        '[getExhibitionDataForLocale]: loaded exhibition data  $exhibitionDataList');
  }

  Future<void> onDeleteExhibitionDataForLocale(
      {required ExhibitionData exhibitionData}) async {
    await _exhibitionService.deletePersistedExhibitionDataFromLocalStorage(
        exhibitionData: exhibitionData);
    _exhibitionDataList.remove(exhibitionData);

    /// workaround because [Selector] does not acknowledge change of list if new list wasnt created
    _exhibitionDataList = [...exhibitionDataList];

    /// if exhibition data of the [_currentLocale] was changed then [_currentLocale]
    final exhibitionDataForCurrentLocaleDeleted =
        exhibitionDataForCurrentLocale == null;

    if (exhibitionDataForCurrentLocaleDeleted &&
        exhibitionDataList.isNotEmpty) {
      _currentLocale = supportedLocales.firstWhereOrNull(
          (element) => element.id == exhibitionDataList.first.id);
    }
    notifyListeners();
  }

  void loadExhibitionDataFromLocalStorage() {
    for (var locale in supportedLocales) {
      var exhibitionData = _exhibitionService
          .tryGetExhibitionDataObjectFromLocalStorage(localeId: locale.name);

      if (exhibitionData != null) {
        exhibitionDataList.add(exhibitionData);
      }
    }
  }
}
