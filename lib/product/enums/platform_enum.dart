import 'dart:io';

enum PlatformEnum {
  ios,
  android;

  static String get versionName {
    if (Platform.isIOS) {
      return PlatformEnum.ios.name;
    }

    if (Platform.isAndroid) {
      return PlatformEnum.android.name;
    }

    throw Exception("Platform unused please check");
  }
}
