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
  checkingIfExhibitionDataAlreadyExists,
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
  List<ExhibitionLocale> get supportedLocales {
    return failureOrSupportedLocales.fold((l) => [], (r) => r);
  }

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

  List<ExhibitionData> _exhibitionDataList = [];
  List<ExhibitionData> get exhibitionDataList => _exhibitionDataList;
  Stream<int>? downloadProgressStream;

  /// This function loads the [ExhibitionData] for the given [locale]
  ///
  /// The function calls [fetchExhibitionData] which returns a stream containing a [Tupel2<ExhibitionData?, int>] of type
  /// the first value of the [Tuple2] is the ExhibitonData which is returned when the second value is equal too 100
  void onLanguageSelected({required ExhibitionLocale locale}) async {
    _state =
        ExhibitoinDataControllerState.checkingIfExhibitionDataAlreadyExists;
    _currentLocale = locale;
    notifyListeners();

    var exhibitionDataProgressTupelStream =
        _exhibitionService.fetchExhibitionData(locale: locale);

    downloadProgressStream =
        exhibitionDataProgressTupelStream.map((exhibitoinDataProgressTupel) {
      final progress = exhibitoinDataProgressTupel.value2;
      final exhibitionData = exhibitoinDataProgressTupel.value1;
      bool dataLoaded = progress == 100;
      bool isDownloading = progress < 100 && progress > 0;

      /// Set state to [downloadingExhibitionData] if data was not not retrieved from cache
      if (isDownloading &&
          _state != ExhibitoinDataControllerState.downloadingExhibitionData) {
        _state = ExhibitoinDataControllerState.downloadingExhibitionData;
        notifyListeners();
      }

      bool exhibitionDataAlreadyExistsInList =
          exhibitionDataList.contains(exhibitionData);
      if (dataLoaded) {
        if (!exhibitionDataAlreadyExistsInList) {
          exhibitionDataList.add(exhibitionData!);
          downloadProgressStream = null;
        }
        _state = ExhibitoinDataControllerState.ready;
        notifyListeners();
      }
      return exhibitoinDataProgressTupel.value2;
    });
    _state = ExhibitoinDataControllerState.ready;
    notifyListeners();

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

    notifyListeners();
  }
}
