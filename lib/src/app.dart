import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gravenhorst_adults_app/src/core/colors.dart';
import 'package:gravenhorst_adults_app/src/core/dependency_injection/dependency_injection.dart';
import 'package:gravenhorst_adults_app/src/core/exhibition_data/exhibition_data_controller.dart';
import 'package:provider/provider.dart';
import 'home/home_page.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ExhibitoinDataController>(
            create: (_) =>
                getIt<ExhibitoinDataController>()..getSupportedLocales())
      ],
      child: MaterialApp(
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
            headline1: TextStyle(fontSize: 61.5),
            headline2: TextStyle(fontSize: 35.0),
            headline3: TextStyle(fontSize: 27.0),
            headline4: TextStyle(fontSize: 18.75),
            headline5: TextStyle(fontSize: 15.75),
            headline6: TextStyle(fontSize: 12.0),
            button: TextStyle(fontSize: 42.0, letterSpacing: 0),
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
      ),
    );
  }
}
