import 'package:flutter/material.dart';

enum LanguageType { English, Turkish, Albanian, German, Norwegian }

const String Turkish = "tr";
const String English = "en";
const String Albanian = "sq";
const String German = "de";
const String Norwegian = "no";
const String ASSETS_PATH_LOCALISATIONS = "assets/translations";
const Locale Turkish_LOCAL = Locale('tr', 'TR');
const Locale English_LOCAL = Locale('en', 'US');
const Locale Albanian_LOCAL = Locale('sq', 'AL');
const Locale German_LOCAL = Locale('de', 'DE');
const Locale Norwegian_LOCAL = Locale("no", "NO");

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.English:
        return English;
      case LanguageType.Turkish:
        return Turkish;
      case LanguageType.Albanian:
        return Albanian;
      case LanguageType.German:
        return German;
      case LanguageType.Norwegian:
        return Norwegian;
    }
  }
}
