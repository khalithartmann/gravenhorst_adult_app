import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:gravenhorst_adults_app/src/core/api_config.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_locale.dart';
import 'package:gravenhorst_adults_app/src/core/failure.dart';
import 'package:gravenhorst_adults_app/src/core/globals.dart';

import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class ExhibitionService {
  ExhibitionService(this._apiConfig, this._client, this._sharedPreferences);

  final ApiConfig _apiConfig;
  final Client _client;
  final SharedPreferences _sharedPreferences;
  String _getexhibitionDataSharedPrefsKey(String localeName) =>
      'exhibitionData_$localeName';

  Future<Either<Failure, List<ExhibitionLocale>>>
      fetchSupportedLocales() async {
    var uri = _apiConfig.getSupportedLocalesUri();
    try {
      var res = await _client.get(uri);
      if (res.statusCode != 200) {
        logger
            .w('[fetchSupportedLocales] returned StatusCode ${res.statusCode}');
        return left(Failure(
            msg: 'Failed to get supported locales from server',
            code: getFailureCodeFromResponse(response: res)));
      }

      var localesJsonList = List.from(jsonDecode(res.body));
      return right(localesJsonList
          .map((localeJson) => ExhibitionLocale.fromJson(localeJson))
          .toList());
    } catch (e, s) {
      return left(Failure(
        msg: '[fetchSupportedLocales] unexpected Failure',
        e: e,
        s: s,
        code: FailureCode.clientError,
      ));
    }
  }

  Stream<Tuple2<ExhibitionData?, int>> fetchExhibitionData(
      {required ExhibitionLocale locale}) async* {
    yield const Tuple2<ExhibitionData?, int>(null, 0);
    var uri = _apiConfig.getTourDataForLocaleUri(localeId: locale.id);

    var exhibitionData =
        tryGetExhibitionDataObjectFromLocalStorage(localeName: locale.name);

    // todo implemented more sufficticated logic.
    //  - check update date etc.
    //  - check if assets are available
    if (exhibitionData != null) {
      yield Tuple2(exhibitionData, 100);
      return;
    }

    try {
      var res = await _client.get(uri);

      if (res.statusCode != 200) {
        logger.w(
            '[fetchExhibitionData] returned StatusCode ${res.statusCode}, body: ${res.body}');
        throw Exception(
          '[fetchExhibitionData] Failed to get exhibition data for locale. Failure Code ${getFailureCodeFromResponse(response: res)}',
        );
      }

      exhibitionData = ExhibitionData.fromJson(jsonDecode(res.body));
      yield* persistExhibitionDataToLocalStorage(
          exhibitionData: exhibitionData);

      await persistExhibitonDataObject(exhibitionData: exhibitionData);

      yield Tuple2(exhibitionData, 100);
    } catch (e, s) {
      logger.w('exception: $e , $s');
      throw Exception(
          '[fetchExhibitionData] Failed to get exhibition data for locale. \n Exception: $s, \stacktrace: $s');
    }
  }

  Stream<Tuple2<Null, int>> persistExhibitionDataToLocalStorage(
      {required ExhibitionData exhibitionData}) async* {
    try {
      var assets = exhibitionData.tours
          .map((tour) => tour.exhibits)
          .expand((element) => element)
          .map((loc) => loc.entries)
          .expand((element) => element)
          .map((entry) => entry.assets)
          .expand((element) => element)
          .toList();

      // delay the percent becuase we dont want to reach 100% in this function
      int downloadedCount = -1;

      for (var asset in assets) {
        if (await asset.existsInLocalStorage()) {
          downloadedCount++;
          int progressInPercentRounded =
              calculateProgressInPercent(downloadedCount, assets);
          yield Tuple2(null, progressInPercentRounded);
        } else {
          yield await tryDownloadFileToDocumentDirectory(asset: asset)
              .then((value) {
            downloadedCount++;
            int progressInPercentRounded =
                calculateProgressInPercent(downloadedCount, assets);
            return Tuple2(null, progressInPercentRounded);
          });
        }
      }
    } catch (e, s) {
      logger.w('[persistExhibitionDataToLocalStorage]: exeption caught $e, $s');
      return;
    }
  }

  int calculateProgressInPercent(int downloadedCount, List<Asset> assets) {
    var progressInPercentRounded =
        ((downloadedCount / assets.length) * 100).round();
    return progressInPercentRounded;
  }

  Future<void> tryDownloadFileToDocumentDirectory(
      {required Asset asset}) async {
    try {
      final uri = Uri.parse(asset.assetUrl);
      final response = await retry(
        () {
          logger.i('Retrying request because previous request failed');
          return _client.get(uri).timeout(const Duration(seconds: 10));
        },
        retryIf: (e) {
          logger.i('Exeption caught $e');
          return e is SocketException || e is TimeoutException;
        },
      );

      await writeBytesToLocalFile(asset, response.bodyBytes);
    } catch (e, s) {
      logger.w(
          '[persistExhibitionDataToLocalStorage] failed to download and persist file',
          e,
          s);
    }
  }

  Future<void> writeBytesToLocalFile(
      Asset currentAsset, Uint8List bytes) async {
    final file = await currentAsset.localFile()
      ..create(recursive: true);
    file.writeAsBytesSync(bytes);
  }

  Future<void> persistExhibitonDataObject(
      {required ExhibitionData exhibitionData}) async {
    var didPersist = await _sharedPreferences.setString(
        _getexhibitionDataSharedPrefsKey(exhibitionData.localeName),
        jsonEncode(exhibitionData.toJson()));

    logger.i(
        '[persistExhibitonDataObject]: Successfully persisted ExhibitionDataObject result: $didPersist');
  }

  Future<void> deletePersistedExhibitionDataFromLocalStorage(
      {required ExhibitionData exhibitionData}) async {
    var didDelete = await _sharedPreferences
        .remove(_getexhibitionDataSharedPrefsKey(exhibitionData.localeName));

    if (didDelete) {
      logger.i(
          'Deleted Exhibition data for locale ${exhibitionData.localeName} ');
    } else {
      logger.i(
          'Failed to delete Exhibition data for locale ${exhibitionData.localeName} ');
    }
  }

  ExhibitionData? tryGetExhibitionDataObjectFromLocalStorage(
      {required String localeName}) {
    var stringObj = _sharedPreferences
        .getString(_getexhibitionDataSharedPrefsKey(localeName));

    if (stringObj == null) {
      return null;
    }

    return ExhibitionData.fromJson(jsonDecode(stringObj));
  }
}
