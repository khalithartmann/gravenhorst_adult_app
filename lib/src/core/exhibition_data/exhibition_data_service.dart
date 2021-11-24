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

  Stream<Tuple2<ExhibitionData?, int>> fetchExhibitionData(
      {required String localeId}) async* {
    yield const Tuple2<ExhibitionData?, int>(null, 0);
    var uri = _apiConfig.getTourDataForLocale(localeId: localeId);

    try {
      var res = await _client.get(uri);

      if (res.statusCode != 200) {
        logger.w(
            '[fetchExhibitionData] returned StatusCode ${res.statusCode}, body: ${res.body}');
        throw Exception(
          '[fetchExhibitionData] Failed to get exhibition data for locale. Failure Code ${getFailureCodeFromResponse(response: res)}',
        );
      }

      var exhibitionData = ExhibitionData.fromJson(jsonDecode(res.body));
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
        yield await tryDownloadFileToDocumentDirectory(asset: asset)
            .then((value) {
          downloadedCount++;
          var progressInPercentRounded =
              ((downloadedCount / assets.length) * 100).round();
          return Tuple2(null, progressInPercentRounded);
        });
      }
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
    print('persisting ... ');
    var didPersist = await _sharedPreferences.setString(
        _exhibitionDataSharedPrefsKey, jsonEncode(exhibitionData.toJson()));

    logger.i(
        '[persistExhibitonDataObject]: Successfully persisted ExhibitionDataObject result: $didPersist');
  }
}
