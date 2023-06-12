import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfile {
  UserProfile(
      {required this.userName,
      required this.surname,
      required this.profilePhotoUrl,
      required this.gender,
      required this.imageList,
      required this.movieList});
  String userName;
  String surname;
  AssetImage profilePhotoUrl;
  String gender;
  List<AssetImage> imageList;
  List<MovieDetail> movieList;
}

class MovieDetail {
  MovieDetail({required this.name, required this.type, required this.id});
  String name;
  String type;
  int id;
}
