import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'nok_nok_localization.dart';

class LocalizationConfigurator {

  // Public methods and properties

  LocalizationConfigurator._();

  static List<Locale> get supportedLocales {
    return [
      Locale('ru', 'RU'),
      Locale('ru', 'UA')
    ];
  }

  static Iterable<LocalizationsDelegate<dynamic>> get localizationDelegates {
    return [
      NokNokLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ];
  }

  static Locale resolveLocale(List<Locale> requestedLocales,
    List<Locale> supportedLocales) {
    for (final requestedLocale in requestedLocales.reversed) {
      for (final supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == requestedLocale.languageCode &&
          supportedLocale.countryCode == requestedLocale.countryCode) {
          return supportedLocale;
        }
      }
    }

    return _fallbackLocale;
  }

  static final _fallbackLocale = Locale('en', 'US');

}