import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:gravenhorst_adults_app/src/core/api_config.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data.dart';
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
    print(uri);
    try {
      // var res = await _client.get(uri);
      // print(res.body);

      // if (res.statusCode != 200) {
      //   logger.w(
      //       '[fetchExhibitionData] returned StatusCode ${res.statusCode}, body: ${res.body}');
      //   return left(Failure(
      //       msg: 'Failed to get exhibition data for locale',
      //       code: getFailureCodeFromResponse(response: res)));
      // }

      var exhibitionData = ExhibitionData.fromJson(jsonDecode('''{
  "id": "de",
  "locale_name": "deutsch",
  "content_size": 3679694,
  "created_at": "2021-11-08T16:01:12Z",
  "updated_at": "2021-11-08T16:01:12Z",
  "tours": [
    {
      "id": 1,
      "name": "default",
      "sort_order": 1,
      "description": "no description",
      "locations": [
        {
          "id": 1,
          "sort_order": 1,
          "name": "01",
          "latitude": "52.2861815",
          "longitude": "7.6239055",
          "marker_color": "#E56849",
          "text_color": "#FFFFFF",
          "entries": [
            {
              "id": 1,
              "sort_order": 1,
              "type": "entryPoint",
              "title": "„Vom Hof zum Kloster“ – Blick auf die heutige Anlage",
              "description": "",
              "background": {
                "image_asset_id": 1,
                "color": "",
                "size": "cover",
                "position": "center"
              },
              "assets": [
                {
                  "id": 1,
                  "sort_order": 1,
                  "asset_url": "https://nordleu.de/gravenhorst_cms/assets/Südgiebel-Westflügel-vorher.jpg",
                  "mime_type": "image/jpg",
                  "description": "Kloster Gravenhorst, Foto: Michael Jezierny",
                  "title": "",
                  "copyright": "",
                  "asset_size": 208896,
                  "asset_duration": 0,
                  "autoplay": false,
                  "updated_at": "2021-11-08T16:01:12Z"
                },
                {
                  "id": 2,
                  "sort_order": 2,
                  "asset_url": "https://nordleu.de/gravenhorst_cms/assets/01-de.m4a",
                  "mime_type": "audio/m4a",
                  "description": "",
                  "title": "",
                  "copyright": "",
                  "asset_size": 264440,
                  "asset_duration": 6,
                  "autoplay": false,
                  "updated_at": "2021-11-08T16:01:12Z"
                }
              ]
            },
            {
              "id": 2,
              "sort_order": 2,
              "type": "selectingGallery",
              "title": "",
              "description": "Die Archäologie konnte insgesamt acht Bauphasen rekonstruieren, durch die im Laufe der Jahrhunderte das Kloster sein Aussehen erhielt.",
              "background": {
                "image_asset_id": 4,
                "color": "",
                "size": "contain",
                "position": ""
              },
              "assets": [
                {
                  "id": 3,
                  "sort_order": 1,
                  "asset_url": "https://nordleu.de/gravenhorst_cms/assets/Bauphasen-1299.jpg",
                  "mime_type": "image/jpg",
                  "description": "Digitale 3D-Rekonstruktion der 1. Bauphase des Klosters um 1256",
                  "title": "1256",
                  "copyright": "",
                  "asset_size": 43357,
                  "asset_duration": 0,
                  "autoplay": false,
                  "updated_at": "2021-11-08T16:01:12Z"
                },
                {
                  "id": 4,
                  "sort_order": 2,
                  "asset_url": "https://nordleu.de/gravenhorst_cms/assets/Bauphasen-1299.jpg",
                  "mime_type": "image/jpg",
                  "description": "Digitale 3D-Rekonstruktion der 2. Bauphase des Klosters um 1299",
                  "title": "1299",
                  "copyright": "",
                  "asset_size": 43357,
                  "asset_duration": 0,
                  "autoplay": false,
                  "updated_at": "2021-11-08T16:01:12Z"
                },
                {
                  "id": 5,
                  "sort_order": 3,
                  "asset_url": "https://nordleu.de/gravenhorst_cms/assets/Bauphasen-1299.jpg",
                  "mime_type": "image/jpg",
                  "description": "Digitale 3D-Rekonstruktion der 3. Bauphase des Klosters um 1314",
                  "title": "1314",
                  "copyright": "",
                  "asset_size": 43357,
                  "asset_duration": 0,
                  "autoplay": false,
                  "updated_at": "2021-11-08T16:01:12Z"
                }
              ]
            },
            {
              "id": 3,
              "sort_order": 3,
              "type": "regular",
              "title": "",
              "description": "Das Kloster wurde durch Mühle, Grund und Boden mit einer wirtschaftlichen Grundlage ausgestattet.",
              "background": {
                "image_asset_id": 5,
                "color": "",
                "size": "contain",
                "position": ""
              },
              "assets": [
                {
                  "id": 6,
                  "sort_order": 1,
                  "asset_url": "https://nordleu.de/gravenhorst_cms/assets/Südgiebel-Westflügel-vorher.jpg",
                  "mime_type": "image/jpg",
                  "description": "Aufnahme während der bauhistorischen Rekonstruktion und der archäologischen Grabung 1999-2002, Foto: LWL-Archäologie für Westfalen.",
                  "title": "",
                  "copyright": "",
                  "asset_size": 208896,
                  "asset_duration": 0,
                  "autoplay": false,
                  "updated_at": "2021-11-08T16:01:12Z"
                }
              ]
            },
            {
              "id": 4,
              "sort_order": 4,
              "type": "regular",
              "title": "",
              "description": "Das Kloster wurde durch Mühle, Grund und Boden mit einer wirtschaftlichen Grundlage ausgestattet.",
              "background": {
                "image_asset_id": 6,
                "color": "",
                "size": "contain",
                "position": ""
              },
              "assets": [
                {
                  "id": 7,
                  "sort_order": 1,
                  "asset_url": "https://nordleu.de/gravenhorst_cms/assets/Kloster_Gravenhorst_Urk_1024x.jpg",
                  "mime_type": "image/jpg",
                  "description": "Gründungurkunde des Klosters Gravenhorst, 17. September 1256, LA NRW Abt. Münster, Kloster Gravenhorst Urk. Nr. 3.",
                  "title": "",
                  "copyright": "",
                  "asset_size": 239338,
                  "asset_duration": 0,
                  "autoplay": false,
                  "updated_at": "2021-11-08T16:01:12Z"
                }
              ]
            }
          ]
        },
        {
          "id": 2,
          "sort_order": 2,
          "name": "02",
          "latitude": "52.2877570",
          "longitude": "7.6230415",
          "marker_color": "#E56849",
          "text_color": "#FFFFFF",
          "entries": [
            {
              "id": 5,
              "sort_order": 1,
              "type": "entryPoint",
              "title": "Westfälischer Adel, Politik und immerwährendes Gedenken – Klostergründung",
              "description": "",
              "background": {
                "image_asset_id": 7,
                "color": "#A2ABAB",
                "size": "",
                "position": ""
              },
              "assets": [
                {
                  "id": 8,
                  "sort_order": 1,
                  "asset_url": "https://nordleu.de/gravenhorst_cms/assets/01-de.m4a",
                  "mime_type": "audio/m4a",
                  "description": "",
                  "title": "",
                  "copyright": "",
                  "asset_size": 264440,
                  "asset_duration": 6,
                  "autoplay": false,
                  "updated_at": "2021-11-08T16:01:12Z"
                }
              ]
            },
            {
              "id": 6,
              "sort_order": 2,
              "type": "regular",
              "title": "",
              "description": "",
              "background": {
                "image_asset_id": 8,
                "color": "",
                "size": "contain",
                "position": ""
              },
              "assets": [
                {
                  "id": 9,
                  "sort_order": 1,
                  "asset_url": "https://nordleu.de/gravenhorst_cms/assets/Einritzung_Gravenhorst_Grabplatte.jpg",
                  "mime_type": "image/jpg",
                  "description": "Stifterehepaar Amalgardis von Budde und Konrad von Brochterbeck, Grabplatte 1281, Katholische Kirche St. Bernhard, Gravenhorst; Die hohen Persönlichkeiten lassen sich auf ihren Grabplatten in der Mode der Zeit darstellen.",
                  "title": "",
                  "copyright": "",
                  "asset_size": 254740,
                  "asset_duration": 0,
                  "autoplay": false,
                  "updated_at": "2021-11-08T16:01:12Z"
                }
              ]
            },
            {
              "id": 7,
              "sort_order": 3,
              "type": "regular",
              "title": "",
              "description": "",
              "background": {
                "image_asset_id": 9,
                "color": "",
                "size": "contain",
                "position": ""
              },
              "assets": [
                {
                  "id": 10,
                  "sort_order": 1,
                  "asset_url": "https://nordleu.de/gravenhorst_cms/assets/Harding_Kirchengründung_um_1125.jpg",
                  "mime_type": "image/jpg",
                  "description": "Das westfälische Stifterpaar erinnert selbstbewusst seine Kirchen- und Klostergründung. Es wählt dazu ein internationales Bildprogramm. Im 12. Jahrhundert präsentierten auch der für die Entwicklung des Zisterzienserordens bedeutsame Abt Stephen Harding (rechts) und der Abt der Benediktineraktei S. Vaast der Gottesmutter so ihre Kirchen. Abbildung: Ezechielkommentar des Hieronymus aus StaintVaast, Arras, fol. 104‘, entstanden in Cîteaux, um 1135, Dijon, Bibliothèque municipale, Ms 130, Katalog, Die Zisterzienser.",
                  "title": "",
                  "copyright": "",
                  "asset_size": 596587,
                  "asset_duration": 0,
                  "autoplay": false,
                  "updated_at": "2021-11-08T16:01:12Z"
                }
              ]
            }
          ]
        },
        {
          "id": 3,
          "sort_order": 3,
          "name": "03",
          "latitude": "52.2868946",
          "longitude": "7.6246133",
          "marker_color": "#E56849",
          "text_color": "#FFFFFF",
          "entries": [
            {
              "id": 8,
              "sort_order": 1,
              "type": "entryPoint",
              "title": "„Zu Ehren der Gottesmutter Maria“ – Der Westflügel",
              "description": "",
              "background": {
                "image_asset_id": 1,
                "color": "#A2ABAB",
                "size": "",
                "position": ""
              },
              "assets": [
                {
                  "id": 11,
                  "sort_order": 1,
                  "asset_url": "https://nordleu.de/gravenhorst_cms/assets/01-de.m4a",
                  "mime_type": "audio/m4a",
                  "description": "",
                  "title": "",
                  "copyright": "",
                  "asset_size": 264440,
                  "asset_duration": 6,
                  "autoplay": false,
                  "updated_at": "2021-11-08T16:01:12Z"
                }
              ]
            },
            {
              "id": 9,
              "sort_order": 2,
              "type": "swipingGallery",
              "title": "",
              "description": "",
              "background": {
                "image_asset_id": 2,
                "color": "",
                "size": "contain",
                "position": ""
              },
              "assets": [
                {
                  "id": 11,
                  "sort_order": 1,
                  "asset_url": "https://nordleu.de/gravenhorst_cms/assets/Harding_Kirchengründung_um_1125.jpg",
                  "mime_type": "image/jpg",
                  "description": "Digitale 3D-Rekonstruktion der 8 Bauphasen des Klosters um 1256.",
                  "title": "",
                  "copyright": "",
                  "asset_size": 596587,
                  "asset_duration": 0,
                  "autoplay": false,
                  "updated_at": "2021-11-08T16:01:12Z"
                },
                {
                  "id": 12,
                  "sort_order": 2,
                  "asset_url": "https://nordleu.de/gravenhorst_cms/assets/Harding_Kirchengründung_um_1125.jpg",
                  "mime_type": "image/jpg",
                  "description": "Digitale 3D-Rekonstruktion der 8 Bauphasen des Klosters um 1709.",
                  "title": "",
                  "copyright": "",
                  "asset_size": 596587,
                  "asset_duration": 0,
                  "autoplay": false,
                  "updated_at": "2021-11-08T16:01:12Z"
                }
              ]
            },
            {
              "id": 10,
              "sort_order": 3,
              "type": "regular",
              "title": "",
              "description": "",
              "background": {
                "image_asset_id": 3,
                "color": "",
                "size": "contain",
                "position": ""
              },
              "assets": [
                {
                  "id": 13,
                  "sort_order": 1,
                  "asset_url": "https://nordleu.de/gravenhorst_cms/assets/Truhen.jpg",
                  "mime_type": "image/jpg",
                  "description": "Fotografien aus Frauenklöstern mit Truhen vor den Kammern.",
                  "title": "",
                  "copyright": "",
                  "asset_size": 54372,
                  "asset_duration": 0,
                  "autoplay": false,
                  "updated_at": "2021-11-08T16:01:12Z"
                }
              ]
            }
          ]
        }
      ]
    }
  ]
}
'''));
      print(exhibitionData);
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
}
