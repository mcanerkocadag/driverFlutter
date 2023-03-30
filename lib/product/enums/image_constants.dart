import 'package:flutter/material.dart';

enum IconConstants {
  appIcon('ic_app_logo');

  final String value;
  // ignore: sort_constructors_first
  const IconConstants(this.value);

  // ignore: empty_constructor_bodies
  String get toPng => 'assets/icons/$value.png';
  Image get toImage => Image.asset(toPng);
}
