import 'package:flutter/material.dart';

enum LanguageType { English, Turkish }

const String Turkish = "tr";
const String English = "en";
const String ASSETS_PATH_LOCALISATIONS = "assets/translations";
const Locale Turkish_LOCAL = Locale("tr", "TR");
const Locale English_LOCAL = Locale("en", "US");

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.English:
        return English;
      case LanguageType.Turkish:
        return Turkish;
    }
  }
}
