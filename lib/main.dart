import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:not_so_secret/app/app.dart';
import 'package:not_so_secret/app/di.dart';
import 'package:flutter/material.dart';
import 'package:not_so_secret/presentation/resources/language_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();

  runApp(
    EasyLocalization(supportedLocales: [English_LOCAL,Turkish_LOCAL],
    path: ASSETS_PATH_LOCALISATIONS,
    child: Phoenix(child : MyApp())));
}
