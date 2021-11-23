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
  final _exhibitionDataSharedPrefsKey = 'exhibitionData';

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

  Future<Either<Failure, ExhibitionData>> fetchExhibitionData(
      {required String localeId}) async {
    var uri = _apiConfig.getTourDataForLocale(localeId: localeId);

    try {
      var res = await _client.get(uri);

      if (res.statusCode != 200) {
        logger.w(
            '[fetchExhibitionData] returned StatusCode ${res.statusCode}, body: ${res.body}');
        return left(Failure(
            msg: 'Failed to get exhibition data for locale',
            code: getFailureCodeFromResponse(response: res)));
      }

      var exhibitionData = ExhibitionData.fromJson(jsonDecode(res.body));
      await persistExhibitionDataToLocalStorage(exhibitionData: exhibitionData);
      await persistExhibitonDataObject(exhibitionData: exhibitionData);

      return right(exhibitionData);
    } catch (e, s) {
      logger.w('exception: $e , $s');
      return left(Failure(
        msg: '[fetchExhibitionData] unexpected Failure',
        e: e,
        s: s,
        code: FailureCode.clientError,
      ));
    }
  }

  Future<void> persistExhibitionDataToLocalStorage(
      {required ExhibitionData exhibitionData}) async {
    try {
      var assets = exhibitionData.tours
          .map((tour) => tour.locations)
          .expand((element) => element)
          .map((loc) => loc.entries)
          .expand((element) => element)
          .map((entry) => entry.assets)
          .expand((element) => element)
          .toList();

      await Future.wait(
        List.generate(
          assets.length,
          (index) => tryDownloadFileToDocumentDirectory(asset: assets[index]),
        ),
      );
    } catch (e, s) {
      logger.w('[persistExhibitionDataToLocalStorage]: exeption caught $e, $s');
      return;
    }
  }

  Future<void> tryDownloadFileToDocumentDirectory(
      {required Asset asset}) async {
    try {
      final uri = Uri.parse(asset.assetUrl);
      final response = await retry(
        () => _client.get(uri).timeout(const Duration(seconds: 5)),
        retryIf: (e) => e is SocketException || e is TimeoutException,
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
    final file = await _localFile(currentAsset.assetUrlLocalPath);
    file.writeAsBytesSync(bytes);
  }

  Future<String> get _documentDirectoryPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _localFile(String filePath) async {
    final path = await _documentDirectoryPath;
    return File('$path/$filePath').create(recursive: true);
  }

  Future<void> persistExhibitonDataObject(
      {required ExhibitionData exhibitionData}) async {
    var didPersist = await _sharedPreferences.setString(
        _exhibitionDataSharedPrefsKey, jsonEncode(exhibitionData.toJson()));

    logger.i(
        '[persistExhibitonDataObject]: Successfully persisted ExhibitionDataObject result: $didPersist');
  }
}
