import 'package:flutter/foundation.dart';
import 'package:flutter_application_firebase/product/utility/exception/custom_exception.dart';

class VersionManager {
  VersionManager({
    required this.deviceValue,
    required this.databaseValue,
  });

  final String deviceValue;
  final String databaseValue;

  bool isNeedUpdate() {
    final deviceNumberSplited = deviceValue.split('.').join('');
    final databaseNumberSplited = databaseValue.split('.').join('');
    final deviceNumber = int.tryParse(deviceNumberSplited);
    final databaseNumber = int.tryParse(databaseNumberSplited);

    if (deviceNumber == null || databaseNumber == null) {
      throw VersionException(
          '$deviceValue or $databaseValue ia not valid for parse');
    }
    return deviceNumber < databaseNumber;
  }
}
