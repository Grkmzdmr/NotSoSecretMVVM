import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:not_so_secret/domain/model/model.dart';
import 'package:flutter/services.dart';

Future<DeviceInfo> getDeviceDetails() async {
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  String name = "Unknown";
  String identifier = "Unknown";
  String version = "Unknown";

  try {
    if (Platform.isAndroid) {
      //return android device info
      var build = await deviceInfoPlugin.androidInfo;
      name = build.brand + " " + build.model;
      identifier = build.androidId;
      version = build.version.codename;
    } else if (Platform.isIOS) {
      //return ios device info
      var build = await deviceInfoPlugin.iosInfo;
      name = build.name + " " + build.model;
      identifier = build.identifierForVendor;
      version = build.systemVersion;
    }
  } on PlatformException {
    //return default data
    return DeviceInfo(name, identifier, version);
  }
  return DeviceInfo(name, identifier, version);
}

