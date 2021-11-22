import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:gravenhorst_adults_app/src/core/api_config.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_locale.dart';
import 'package:gravenhorst_adults_app/src/core/failure.dart';
import 'package:gravenhorst_adults_app/src/core/globals.dart';

import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

@singleton
class ExhibitionService {
  final ApiConfig _apiConfig;
  final Client _client;

  ExhibitionService(this._apiConfig, this._client);
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

      var localesJsonList = List.from(jsonDecode('''
      [
  {
    "id": "de",
    "name": "deutsch"
  },
  {
    "id": "en",
    "name": "english"
  },
  {
    "id": "nl",
    "name": "nederlands"
  },
  {
    "id": "de_LS",
    "name": "deutsch, leichte Sprache"
  }
]'''));
      return right(localesJsonList
          .map((localeJson) => ExhibitionLocale.fromJson(localeJson))
          .toList());
    } on ClientException catch (e, s) {
      return left(Failure(
        msg: '[fetchSupportedLocales] unexpected Failure',
        e: e,
        s: s,
        code: FailureCode.clientError,
      ));
    }
  }
}
