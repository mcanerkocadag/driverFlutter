import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/feature/auth/authentication_view.dart';
import 'package:flutter_application_firebase/feature/choosePhotos/choose_photos.dart';
import 'package:flutter_application_firebase/feature/createProfile/create_profile.dart';
import 'package:flutter_application_firebase/feature/examplePage/example_Page.dart';
import 'package:flutter_application_firebase/feature/home/home_view.dart';
import 'package:flutter_application_firebase/feature/moviePages/movie_pages.dart';
import 'package:flutter_application_firebase/product/initialize/app_theme.dart';
import 'package:flutter_application_firebase/product/initialize/application_start.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  await ApplicationStart.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: AuthenticationView(),
      theme: AppTheme(context).theme,
    );
  }
}
