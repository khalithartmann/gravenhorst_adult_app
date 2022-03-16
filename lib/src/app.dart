import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:gravenhorst_adults_app/src/core/dependency_injection/dependency_injection.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data_controller.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'home/home_page.dart';

/// The Widget that configures your application.
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ExhibitoinDataController>(
          create: (context) =>
              getIt<ExhibitoinDataController>()..getSupportedLocales(),
        )
      ],
      child: FutureBuilder(
          future: getIt.allReady(),
          builder: (context, snapshot) {
            print(snapshot);
            if (!snapshot.hasData) {
              return MaterialApp();
            }

            print(context.read<ExhibitoinDataController>().currentLocale?.id);
            return MaterialApp(
              // Providing a restorationScopeId allows the Navigator built by the
              // MaterialApp to restore the navigation stack when a user leaves and
              // returns to the app after it has been killed while running in the
              // background.
              restorationScopeId: 'app',

              // Provide the generated AppLocalizations to the MaterialApp. This
              // allows descendant Widgets to display the correct translations
              // depending on the user's locale.
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('de', ''), // English, no country code
                Locale('en', ''),
              ],

              locale: Locale(
                  context.watch<ExhibitoinDataController>().currentLocale?.id ??
                      'de'),

              // Use AppLocalizations to configure the correct application title
              // depending on the user's locale.
              //
              // The appTitle is defined in .arb files found in the localization
              // directory.
              onGenerateTitle: (BuildContext context) =>
                  AppLocalizations.of(context)!.appTitle,

              // Define a light and dark color theme. Then, read the user's
              // preferred ThemeMode (light, dark, or system default) from the
              // SettingsController to display the correct theme.
              theme: ThemeData(
                appBarTheme: const AppBarTheme(backgroundColor: deepOrange),
                fontFamily: 'DIN',
                primaryColor: deepOrange,
                textTheme: const TextTheme(
                  headline1: TextStyle(fontSize: 82),
                  headline2: TextStyle(fontSize: 52),
                  headline3: TextStyle(fontSize: 29),
                  headline4: TextStyle(fontSize: 25),
                  headline5: TextStyle(fontSize: 22),
                  headline6: TextStyle(fontSize: 14),
                  button: TextStyle(fontSize: 35),
                  bodyText1: TextStyle(fontSize: 32),
                  bodyText2: TextStyle(fontSize: 14),
                ),
              ),

              // Define a function to handle named routes in order to support
              // Flutter web url navigation and deep linking.
              onGenerateRoute: (RouteSettings routeSettings) {
                return MaterialPageRoute<void>(
                  settings: routeSettings,
                  builder: (BuildContext context) {
                    switch (routeSettings.name) {
                      case HomePage.routeName:
                      default:
                        return const HomePage();
                    }
                  },
                );
              },
            );
          }),
    );
  }
}
