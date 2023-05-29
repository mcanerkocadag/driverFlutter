import 'package:flutter/material.dart';

enum IconConstants {
  appIcon('ic_app_logo'),
  profileDummy('im_profile_dummy'),
  btnSend('ic_btn_send'),
  heart('ic_heart'),
  superLike('ic_superlike'),
  dislike('ic_dislike'),
  searchIcon('im_search');

  final String value;
  // ignore: sort_constructors_first
  const IconConstants(this.value);

  // ignore: empty_constructor_bodies
  String get toPng => 'assets/icons/$value.png';
  Image get toImage => Image.asset(toPng);
}
