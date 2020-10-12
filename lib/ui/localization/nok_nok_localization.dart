import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Utility method to reduce amount of code
String translate(BuildContext context, String key) {
  return NokNokLocalizations.of(context).translate(key);
}

class NokNokLocalizations {

  // Public methods and properties

  static const LocalizationsDelegate<NokNokLocalizations> delegate = _NokNokLocalizationsDelegate();

  final Locale locale;

  NokNokLocalizations(this.locale);

  static NokNokLocalizations of(BuildContext context) {
    return Localizations.of(context, NokNokLocalizations);
  }

  Future load() async {
    final jsonString = await rootBundle.loadString(_localeFilePath);
    _localizedStrings = json.decode(jsonString);
  }

  String translate(String key) {
    var result = _localizedStrings[key];
    if (result == null) {
      result = '<<$key>>';
    }

    return result.toString();
  }

  // Internal methods

  String get _localeFilePath {
    return 'lib/resources/localization/${locale.languageCode}.json';
  }

  // Internal fields

  Map<String, dynamic> _localizedStrings;

}

class _NokNokLocalizationsDelegate extends LocalizationsDelegate<NokNokLocalizations> {

  const _NokNokLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ru'].contains(locale.languageCode);
  }

  @override
  Future<NokNokLocalizations> load(Locale locale) async {
    var localizations = NokNokLocalizations(locale);
    await localizations.load();

    return localizations;
  }

  @override
  bool shouldReload(LocalizationsDelegate<NokNokLocalizations> old) => false;

}